#!/bin/sh

## Standard update && upgrade
aptitude update -y
aptitude upgrade -y

## Nice things to have
aptitude install -y unzip iftop htop 
## Needed packages for XBMC
aptitude install -y git-core build-essential gawk pmount libtool nasm yasm automake cmake gperf zip unzip bison libsdl-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libfribidi-dev liblzo2-dev libfreetype6-dev libsqlite3-dev libogg-dev libasound2-dev python-sqlite libglew-dev libcurl3 libcurl4-gnutls-dev libxrandr-dev libxrender-dev libmad0-dev libogg-dev libvorbisenc2 libsmbclient-dev libmysqlclient-dev libpcre3-dev libdbus-1-dev libhal-dev libhal-storage-dev libjasper-dev libfontconfig-dev libbz2-dev libboost-dev libenca-dev libxt-dev libxmu-dev libpng-dev libjpeg-dev libpulse-dev mesa-utils libcdio-dev libsamplerate-dev libmpeg3-dev libflac-dev libiso9660-dev libass-dev libssl-dev fp-compiler gdc libmpeg2-4-dev libmicrohttpd-dev libmodplug-dev libssh-dev gettext cvs python-dev libyajl-dev libboost-thread-dev libplist-dev libusb-dev libudev-dev libtinyxml-dev libcap-dev curl swig default-jre
## Extra for >= 10.10:
aptitude install -y autopoint libltdl-dev
## Extra for >= 12.10
aptitude install -y libtag1-dev
## Extra for XBMC, won't compile without
aptitude install -y libtiff-dev
## Windowmanager
aptitude install -y xinit



## Hardware accelleration support
aptitude install -y libva1 libva-dev xvba-va-driver

## Installing AMD HD6310 drivers
wget http://www2.ati.com/drivers/linux/amd-driver-installer-catalyst-12.10-x86.x86_64.zip
unzip amd-driver-installer-catalyst-12.10-x86.x86_64.zip 
sh amd-driver-installer-catalyst-12.10-x86.x86_64.run --extract ati
cd ati
./ati-installer.sh --buildpkg Ubuntu/quantal
cd ../
rm -rf ati
dpkg -i fglrx*.deb


## Downloading and compiling XBMC
git clone https://github.com/xbmc/xbmc.git
cd xbmc/
git checkout Eden
./bootstrap 
./configure --enable-vaapi
make -j2
make install DESTDIR=/usr/bin/