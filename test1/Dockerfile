FROM ubuntu:14.04
MAINTAINER Daisuke,Ueki <d.ueki@appliedelectroics.jp>

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get update && apt-get install -y \
	python-software-properties software-properties-common ;\
	echo | add-apt-repository ppa:ubuntu-toolchain-r/test ;apt-get update;\
	apt-get install -y build-essential g++-4.8 libxml++2.6-dev libssl-dev \
	libboost1.54-all-dev libpng-dev libdwarf-dev subversion subversion-tools svn2cl \
	autotools-dev autoconf libtool cmake git make wget \
	build-essential dh-make fakeroot devscripts pbuilder cdbs \
	fonts-migmix xfonts-shinonome supervisor \
	 dictionaries-common
RUN apt-get install -y xfce4
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 20 ;\
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 20
# install C++ REST API library(casablanca)
RUN git clone https://git01.codeplex.com/casablanca ; cd casablanca/Release ;\
	mkdir build.release ; cd build.release;CXX=g++-4.8 cmake .. -DCMAKE_BUILD_TYPE=Release ;\
	make ; cp Binaries/libcpprest.so /usr/lib ; ldconfig ; mkdir -p /usr/include/casablanca ;\
	cp -ra ../../Release/include/* /usr/include/casablanca 
#RUN cd casablanca/Release/build.release/Binaries ; ./test_runner *_test.so

# 4 RDP Server used
RUN apt-get install -y libpam0g libssl1.0.0 libx11-6 libxfixes3 adduser libxrandr2 libjpeg-dev
# RDP Server develop
RUN apt-get install -y \
	libkrb5-dev libpam0g-dev libx11-dev libxfixes-dev libxrandr-dev libjpeg-dev \
	xorg-dev flex bison python-libxml2

RUN git clone https://github.com/neutrinolabs/xrdp.git
# add librfxcodec
RUN cd xrdp && rmdir librfxcodec && \
	git clone https://github.com/neutrinolabs/librfxcodec.git && cd librfxcodec && \
	git checkout 5ed7ab6bda48ebddd4820544d0558eaec225a8f5 && \
	make all && cp include/rfxcodec_encode.h /usr/include && \
	cp -a src/librfxencode.so src/librfxencode.a /usr/lib && ldconfig
# add xrdp(RDP server)
RUN apt-get install -y libavcodec-dev libavformat-dev
RUN cd xrdp && ./bootstrap && ./configure --enable-rfxcodec && make && make install
RUN useradd sconnect -m -s /bin/bash ; echo sconnect:password | chpasswd
ADD Xclients /etc/skel/.Xclients
ADD xrdp.conf /etc/supervisor/conf.d/ 
ADD gen-xrdp-rsakey /usr/sbin/
RUN chmod +x /usr/sbin/gen-xrdp-rsakey
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini; \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
# patch Keyboard issue and Japanise Keyboard Layout
# http://www.mail-archive.com/xrdp-devel@lists.sourceforge.net/msg00263/km-e0010411.ini
ADD km-e0010411.ini /etc/xrdp/
RUN ln -is km-e0010411.ini /etc/xrdp/km-0411.ini && \
	ln -is km-e0010411.ini /etc/xrdp/km-e0200411.ini && \
	ln -is km-e0010411.ini /etc/xrdp/km-e0210411.ini

EXPOSE 3389
CMD ["supervisord", "-n" ]
#for debug
#CMD ["/bin/bash"]
