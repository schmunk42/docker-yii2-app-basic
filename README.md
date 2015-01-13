# Docker Container for Yii2 Basic App Template

## Usage

Get it!

    docker pull schmunk42/yii2-app-basic

Run the container

    docker run -d -p 8888:80 schmunk42/yii2-app-basic

Open [http://127.0.0.1:8888](http://127.0.0.1:8888) (Linnx) or [http://192.168.59.103:8888](http://192.168.59.103:8888) (OS X, Windows) in your browser.

## Development

    docker run \
        -v `pwd`/myapp:/app-install \
        schmunk42/yii2-app-basic \
        cp -a /app/. /app-install
        
Mount application as volume    

    cd myapp

    docker run -d -p 8888:80 \
        -v `pwd`:/app \
        --name myapp \
        schmunk42/yii2-app-basic
        
**If you would like to use a Yii 2.0 Framework application with a Docker-optimized setup based on environment variables, you
should have a look at [Phundament 4](http://phundament.com).**
