# Docker Container for Yii2 Basic App Template

## Usage

Run the container

    docker run -d -p 8888:80 yii2-basic-app
    
Mount application as volume    

    cd my-basic-app
    
    docker run -d -p 8888:80 \
        -v .:/app
        yii2-basic-app
    
**If you would like to use a Yii 2.0 Framework application with a Docker-optimized setup based on environment variables, you
should have a look at [Phundament 4](http://phundament.com).**