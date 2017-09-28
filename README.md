# Docker Container for Yii 2.0

---

:bangbang: **We've released [`docker-yii2-app`](https://github.com/dmstr/docker-yii2-app) an updated version of a minimalistic Yii 2.0 application template.**

---


**Basic App Template**

> Note! This docker container was created as a very basic Yii2 example. 
> 
> **If you would like to use a Yii 2.0 Framework application with a Docker-optimized setup based on environment variables, you
should have a look at [phd5](https://github.com/dmstr/phd5-app).**

## Usage

Get it from [Docker Hub](https://registry.hub.docker.com/u/schmunk42/yii2-app-basic/)!

    docker pull schmunk42/yii2-app-basic

Run the container

    docker run -p 8888:80 schmunk42/yii2-app-basic

Open [http://127.0.0.1:8888](http://127.0.0.1:8888) (Linnx) or [http://192.168.59.103:8888](http://192.168.59.103:8888) (OS X, Windows) in your browser.

Use `Ctrl+c` to stop the process, you can also start the docker process in the background, by adding the `-d` or `--detach` option.

## Development

Copy the applictaion template from the image to your host, the following command will create a `myapp` app folder in your working directory.

    docker run \
        -v `pwd`/myapp:/app-install \
        schmunk42/yii2-app-basic \
        cp -a /app/. /app-install

Now as you have the source-code on your host system, mount the application as volume an re-run the container

    cd myapp

    docker run -d -p 8888:80 \
        -v `pwd`:/app \
        --name myapp \
        schmunk42/yii2-app-basic

Access the application under the URLs mentioned above, you can directly edit the files of your application or run commands like

    docker exec myapp ./yii

directly off the running container.

Links
-----

- [yii2-app-basic](https://github.com/yiisoft/yii2-app-basic)
- [Phundament 4](http://phundament.com)
- [diemeisterei GmbH](http://diemeisterei.de)
