FROM ubuntu:12.04
MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get update && \
    apt-get install -y wget vim git gcc make net-tools supervisor \
    x11vnc xvfb openbox gtk2-engines-murrine ttf-ubuntu-font-family \ 
    xfonts-shinonome fonts-takao gdebi-core firefox
RUN \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    echo y | gdebi google-chrome-stable_current_amd64.deb && rm *.deb
RUN \
    wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=95116 -O java.tar.gz && \
    mkdir /usr/java && cd /usr/java && tar xvf /java.tar.gz && \
    JAVA_PLUGIN=`ls /usr/java/*/lib/amd64/libnpjp2.so` && \
    mkdir -p /opt/google/chrome/plugins && ln -s $JAVA_PLUGIN /opt/google/chrome/plugins/libnpjp2.so  
RUN useradd sconnect -m -s /bin/bash ; echo sconnect:password | chpasswd
RUN \
    JAVA_PLUGIN=`ls /usr/java/*/lib/amd64/libnpjp2.so` && \
    mkdir -p /home/sconnect/.mozilla/plugins && \
    ln -s $JAVA_PLUGIN /home/sconnect/.mozilla/plugins/libnpjp2.so && \
    chown -R sconnect.sconnect /home/sconnect/.mozilla 
RUN \
    git clone https://github.com/kanaka/noVNC.git
ADD self.pem /noVNC/utils/
RUN cd /noVNC/utils && make
ADD vncsv.conf /etc/supervisor/conf.d/
RUN mkdir /home/sconnect/.vnc
ADD passwd /home/sconnect/.vnc/
RUN chown -R sconnect.sconnect /home/sconnect/.vnc && chmod 600 /home/sconnect/.vnc/passwd
RUN mkdir /var/log/novnc && chown -R sconnect.sconnect /var/log/novnc
EXPOSE 6080 
CMD ["supervisord", "-n" ]
#for debug
#CMD ["/bin/bash"]
