#/bin/sh
#FROM duekiaec/bootcamp:ctrl-orig 
#MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

rm -rf /etc/yum.repos.d/*.repo
cp -a /var/www/html/aec.repo /etc/yum.repos.d/
yum install -y nginx git python-setuptools
sed -i "1i daemon off;" /etc/nginx/nginx.conf
mkdir -p /var/log/nginx/log
cd /tmp && git clone https://github.com/Supervisor/supervisor.git && \
cd supervisor && git checkout 3.1.2 && python setup.py install && \
rm -rf /tmp/supervisor 
