FROM ubuntu:12.04
MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get update && apt-get install -y wget vim
ADD opensuse.list /etc/apt/sources.list.d/
RUN \
	wget -O - http://download.opensuse.org/repositories/home:/felfert/Debian_6.0/Release.key | apt-key add - &&\
	apt-get update && apt-get install -y wsgate

#EXPOSE 3389
#CMD ["supervisord", "-n" ]
#for debug
CMD ["/bin/bash"]
