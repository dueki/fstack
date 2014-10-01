#!/bin/sh
. ./release
sudo docker build -t ctrl .
sudo docker run -t -v /var/www/html:/var/www/html:rw ctrl /bin/bash /home/sconnect/post-build.sh
CON=`sudo docker ps -a | awk 'NR==2' | awk '{ print $1};'`
sudo docker commit $CON
IMG=`sudo docker images | awk 'NR==2' | awk '{ print $3};'`
sudo docker tag $IMG duekiaec/bootcamp:ctrl-$RELEASE
