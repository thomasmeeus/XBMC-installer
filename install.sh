#!/bin/sh

## Standard update && upgrade
aptitude update -y
aptitude upgrade -y



## Nice things to have
aptitude install -y iftop htop python-software-properties lm-sensors
## Power saving tools
aptitude install -y pm-utils acpi-support laptop-mode-tools powertop upower
## Needed packages for XBMC
aptitude install -y git-core build-essential gawk pmount libtool nasm yasm automake cmake gperf zip unzip bison libsdl-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libfribidi-dev liblzo2-dev libfreetype6-dev libsqlite3-dev libogg-dev libasound2-dev python-sqlite libglew-dev libcurl3 libcurl4-gnutls-dev libxrandr-dev libxrender-dev libmad0-dev libogg-dev libvorbisenc2 libsmbclient-dev libmysqlclient-dev libpcre3-dev libdbus-1-dev libhal-dev libhal-storage-dev libjasper-dev libfontconfig-dev libbz2-dev libboost-dev libenca-dev libxt-dev libxmu-dev libpng-dev libjpeg-dev libpulse-dev mesa-utils libcdio-dev libsamplerate-dev libmpeg3-dev libflac-dev libiso9660-dev libass-dev libssl-dev fp-compiler gdc libmpeg2-4-dev libmicrohttpd-dev libmodplug-dev libssh-dev gettext cvs python-dev libyajl-dev libboost-thread-dev libplist-dev libusb-dev libudev-dev libtinyxml-dev libcap-dev curl swig default-jre
## Extra for >= 10.10:
aptitude install -y autopoint libltdl-dev
## Extra for >= 12.10
aptitude install -y libtag1-dev
## Extra for XBMC, won't compile without
aptitude install -y libtiff-dev 
wget http://packages.medibuntu.org/pool/free/libd/libdvdcss/libdvdcss2_1.2.9-2medibuntu4_i386.deb
dpkg -i libdvdcss2_1.2.9-2medibuntu4_i386.deb
rm libdvdcss2_1.2.9-2medibuntu4_i386.deb
## Windowmanager
aptitude install -y xinit
## Hardware accelleration support
aptitude install -y libva1 libva-dev xvba-va-driver
## Install LibCEC for CEC support
#aptitude install -y libcec2 libcec-dev cec-utils

## Compoling libCEC from git
aptitude install -y liblockdev1 liblockdev1-dev autoconf pkg-config libudev-dev
git clone git://github.com/Pulse-Eight/libcec.git
cd libcec
./bootstrap
./configure
make -j2
make install
cd ../
rm -rf libcec 

## Installing AMD HD6310 drivers
wget http://www2.ati.com/drivers/linux/amd-driver-installer-catalyst-12.10-x86.x86_64.zip
unzip amd-driver-installer-catalyst-12.10-x86.x86_64.zip 
sh amd-driver-installer-catalyst-12.10-x86.x86_64.run --install --force
rm amd-driver-installer-catalyst-12.10-x86.x86_64.run
rm amd-driver-installer-catalyst-12.10-x86.x86_64.zip


## Downloading and compiling XBMC
git clone https://github.com/xbmc/xbmc.git
cd xbmc/
git checkout Eden ## better to use master with libcec?
./bootstrap 
./configure --enable-vaapi --enable-libcec=yes --prefix=/usr/bin/xbmc 
make -j2
make install
cd ../
rm -rf xbmc 

## Moving init script to its place

mv xbmc /etc/init.d/xbmc




## Creating users

# adduser xbmc
# addgroup admin  --system
# adduser xbmc admin
# adduser xbmc admin 
# adduser xbmc adm 
# adduser xbmc dialout 
# adduser xbmc cdrom 
# adduser xbmc floppy 
# adduser xbmc audio 
# adduser xbmc dip 
# adduser xbmc video 
# adduser xbmc plugdev 
# adduser xbmc fuse
# adduser xbmc sudo

# ## Editing sudoers file
# echo "%admin  ALL=(ALL) ALL" >> /etc/sudoers
# echo "xbmc ALL=NOPASSWD: /bin/mount, /bin/umount, /sbin/reboot, /sbin/shutdown" >> /etc/sudoers






## Power savings
echo 5 > /proc/sys/vm/laptop_mode
echo 0 > /proc/sys/kernel/nmi_watchdog
echo Y > /sys/module/snd_ac97_codec/parameters/power_save
echo 1 > /sys/devices/system/cpu/sched_mc_power_savings
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
for i in /sys/bus/usb/devices/*/power/autosuspend; do echo 1 > $i; done
echo min_power > /sys/class/scsi_host/host0/link_power_management_policy
echo min_power > /sys/class/scsi_host/host1/link_power_management_policy
## Disabe WOL
ethtool -s eth0 wol d

### Experimental


aptitude install pm-utils policykit
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.suspend &>> ~/setup/logs/xci-installer.log
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.hibernate &>> ~/setup/logs/xci-installer.log
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.reboot &>> ~/setup/logs/xci-installer.log
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.shutdown &>> ~/setup/logs/xci-installer.log
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.reboot-multiple-sessions &>> ~/setup/logs/xci-installer.log
polkit-auth --user xbmc --grant org.freedesktop.hal.power-management.shutdown-multiple-sessions &>> ~/setup/logs/xci-installer.log
			
