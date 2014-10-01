#!/bin/sh
. ./release
if [ ! -d ~/log/nginx/log ]; then
    mkdir -p ~/log/nginx/log
fi
sudo docker run -it -p 80:80 -v /var/www/html:/var/www/html:rw \
-v ~/log/nginx:/var/log/nginx:rw duekiaec/bootcamp:ctrl-$RELEASE \
/bin/bash 
