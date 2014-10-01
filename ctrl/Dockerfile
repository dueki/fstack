FROM duekiaec/bootcamp:ctrl-orig 
MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

RUN ln -isf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
ADD nginx_signing.key /etc/pki/rpm-gpg/
ADD supervisord.conf /etc/
RUN \
    chmod 644 /etc/supervisord.conf && \
    mkdir -p /etc/supervisor/conf.d && \
    mkdir -p /var/log/supervisor/
RUN useradd sconnect -m -s /bin/bash ; echo sconnect:password | chpasswd
ADD post-build.sh /home/sconnect/
RUN chmod +x /home/sconnect/post-build.sh && mkdir -p /var/www/html
ADD repo-server.conf /etc/supervisor/conf.d/
ADD default.conf /etc/nginx/conf.d/
EXPOSE 80
CMD ["supervisord", "-n" ]
#for debug
#CMD ["/bin/bash"]
