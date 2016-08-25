FROM debian:jessie

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need an apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Update and install system base packages
ENV IMAGE_PRODUCTION_APT_GET_DATE 2015-01-07-22-44
RUN apt-get update && \
    apt-get install -y \
        git \
        mercurial \
        curl \
        nginx \
        mysql-client \
        php5-fpm \
        php5-curl \
        php5-cli \
        php5-gd \
        php5-intl \
        php5-mcrypt \
        php5-mysql \
        php5-pgsql \
        php5-xsl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize application
WORKDIR /app

# Install composer && global asset plugin (Yii 2.0 requirement)
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
ADD config.json /root/.composer/config.json
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin"

# Install application template and packages
# Yii 2.0 application and its extensions can be used directly from the image or serve as local cache
RUN /usr/local/bin/composer create-project --prefer-dist \
    yiisoft/yii2-app-basic:2.* \
    /app

# Configure nginx
ADD default /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \
    sed -i.bak 's/variables_order = "GPCS"/variables_order = "EGPCS"/' /etc/php5/fpm/php.ini && \
    sed -i.bak '/;catch_workers_output = yes/ccatch_workers_output = yes' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/log_errors_max_len = 1024/log_errors_max_len = 65536/' /etc/php5/fpm/php.ini
# forward request and error logs to docker log collector
RUN ln -sf /dev/stderr /var/log/nginx/error.log
# /!\ DEVELOPMENT ONLY SETTINGS /!\
# Running PHP-FPM as root, required for volumes mounted from host
RUN sed -i.bak 's/user = www-data/user = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/group = www-data/group = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/--fpm-config /-R --fpm-config /' /etc/init.d/php5-fpm
# /!\ DEVELOPMENT ONLY SETTINGS /!\

ADD run.sh /root/run.sh
RUN chmod 700 /root/run.sh

CMD ["/root/run.sh"]
EXPOSE 80
