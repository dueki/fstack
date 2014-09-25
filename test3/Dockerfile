FROM ubuntu:12.04
MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get update && apt-get install -y wget vim git gcc make net-tools supervisor
RUN apt-get install -y x11vnc vnc4server
RUN apt-get install -y sawfish xinetd
RUN apt-get install -y chromium-browser-l10n
RUN useradd sconnect -m -s /bin/bash ; echo sconnect:password | chpasswd
#RUN mkdir -p /home/sconnect/.vnc && chown -R sconnect:sconnect /home/sconnect/.vnc && \
RUN git clone https://github.com/kanaka/noVNC.git
ADD self.pem /noVNC/utils/
RUN cd /noVNC/utils && make
ADD vncsv.conf /etc/supervisor/conf.d/
RUN mkdir /home/sconnect/.vnc
ADD passwd /home/sconnect/.vnc/
RUN chown -R sconnect.sconnect /home/sconnect/.vnc && chmod 600 /home/sconnect/.vnc/passwd
EXPOSE 6080 
CMD ["supervisord", "-n" ]
#for debug
#CMD ["/bin/bash"]
