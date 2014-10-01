#/bin/sh
sudo docker ps -a --filter "dangling=true" | gawk '{ print $1 }' | xargs sudo docker rm
sudo docker images --filter dangling=true | gawk '{ print  $3 }' | xargs sudo docker rmi
