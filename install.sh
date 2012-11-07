#!/bin/sh

## Standard update && upgrade
aptitude update -y
aptitude upgrade -y

## Nice things to have
aptitude install -y iftop htop powertop python-software-properties software-properties-common lm-sensors iw vim unzip

## Windowmanager
aptitude install -y xinit

## Hardware accelleration support
aptitude install -y libva1 libva-dev xvba-va-driver




## Installing AMD HD6310 drivers
wget http://www2.ati.com/drivers/linux/amd-driver-installer-catalyst-12.10-x86.x86_64.zip
unzip amd-driver-installer-catalyst-12.10-x86.x86_64.zip 
sh amd-driver-installer-catalyst-12.10-x86.x86_64.run --install --force
rm amd-driver-installer-catalyst-12.10-x86.x86_64.run
rm amd-driver-installer-catalyst-12.10-x86.x86_64.zip
aticonfig --initial




## Needed packages for XBMC
aptitude install -y git-core build-essential gawk pmount libtool nasm yasm automake cmake gperf zip unzip bison libsdl-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libfribidi-dev liblzo2-dev libfreetype6-dev libsqlite3-dev libogg-dev libasound2-dev python-sqlite libglew-dev libcurl3 libcurl4-gnutls-dev libxrandr-dev libxrender-dev libmad0-dev libogg-dev libvorbisenc2 libsmbclient-dev libmysqlclient-dev libpcre3-dev libdbus-1-dev libhal-dev libhal-storage-dev libjasper-dev libfontconfig-dev libbz2-dev libboost-dev libenca-dev libxt-dev libxmu-dev libpng-dev libjpeg-dev libpulse-dev mesa-utils libcdio-dev libsamplerate-dev libmpeg3-dev libflac-dev libiso9660-dev libass-dev libssl-dev fp-compiler gdc libmpeg2-4-dev libmicrohttpd-dev libmodplug-dev libssh-dev gettext cvs python-dev libyajl-dev libboost-thread-dev libplist-dev libusb-dev libudev-dev libtinyxml-dev libcap-dev curl swig default-jre

## Extra for >= 10.10:
aptitude install -y autopoint libltdl-dev

## Extra for >= 12.10
aptitude install -y libtag1-dev

## Extra for XBMC, won't compile without
aptitude install -y libtiff-dev 





## Install LibCEC for CEC support
aptitude install -y liblockdev1 liblockdev1-dev autoconf pkg-config 
git clone git://github.com/Pulse-Eight/libcec.git
cd libcec
./bootstrap
./configure --prefix=/usr/local
make -j2
make install
cd ../
rm -rf libcec 





## Downloading and compiling XBMC
git clone git://github.com/xbmc/xbmc.git
cd xbmc/
#git checkout Master ## better to use master with libcec?
./bootstrap 
./configure --enable-vaapi --enable-libcec=yes --prefix=/usr/local
make -j2
make install
cd ../
rm -rf xbmc 

## Moving init script to its place
mv xbmc /etc/init.d/xbmc
## Moving advancedsettings to its place
cp advancedsettings.xml /home/xbmc/.xbmc/userdata/advancedsettings.xml



## Creating users
adduser xbmc
addgroup admin  --system
adduser xbmc admin
adduser xbmc admin 
adduser xbmc adm 
adduser xbmc dialout 
adduser xbmc cdrom 
adduser xbmc floppy 
adduser xbmc audio 
adduser xbmc dip 
adduser xbmc video 
adduser xbmc plugdev 
adduser xbmc fuse
adduser xbmc sudo

 ## Editing sudoers file
sed -i 's/#includedir/includedir' /etc/sudoers
sed -i 's/console/anybody/' /etc/X11/Xwrapper.config 
echo "%admin  ALL=(ALL) ALL" > /etc/sudoers.d/admin
echo "xbmc ALL=NOPASSWD: /bin/mount, /bin/umount, /sbin/reboot, /sbin/shutdown" > /etc/sudoers.d/xbmc



## Enabling acpi control in xbmc
aptitude install -y policykit-1 upower acpi-support pm-utils
mv custom-actions.pkla /var/lib/polkit-1/localauthority/50-local.d/

## Setting some custom xbmc settings
sed -i 's <enablerssfeeds>true</enablerssfeeds> <enablerssfeeds>false</enablerssfeeds> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <guisoundmode>1</guisoundmode> <guisoundmode>0</guisoundmode> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <disablejoystickwithimon>false</disablejoystickwithimon> <disablejoystickwithimon>true</disablejoystickwithimon> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <enablejoystick>true</enablejoystick> <enablejoystick>false</enablejoystick> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <enablemouse>true</enablemouse> <enablemouse>false</enablemouse> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <remoteaskeyboard>true</remoteaskeyboard> <remoteaskeyboard>false</remoteaskeyboard> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <guisoundmode>1</guisoundmode> <guisoundmode>0</guisoundmode> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <ac3passthrough>false</ac3passthrough> <ac3passthrough>true</ac3passthrough> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <dtshdpassthrough>false</dtshdpassthrough> <dtshdpassthrough>true</dtshdpassthrough> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <dtspassthrough>false</dtspassthrough> <dtspassthrough>true</dtspassthrough> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <multichannellpcm>false</multichannellpcm> <multichannellpcm>true</multichannellpcm> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <passthroughaac>false</passthroughaac> <passthroughaac>true</passthroughaac> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <truehdpassthrough>false</truehdpassthrough> <truehdpassthrough>true</truehdpassthrough> ' /home/xbmc/.xbmc/userdata/guisettings.xml
sed -i 's <subtitlelanguage>original</subtitlelanguage> <subtitlelanguage>dutch</subtitlelanguage> ' /home/xbmc/.xbmc/userdata/guisettings.xml
## Using = as delimiter
sed -i 's=<country>USA</country>=<country>Central Europe</country>=' /home/xbmc/.xbmc/userdata/guisettings.xml
     


                



## Tweak: reduce usb power consumption (why not?) 
## Using $ as delimiter
sed -i 's$GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"$GRUB_CMDLINE_LINUX_DEFAULT="quiet splash usbcore.autosuspend=-1"$' /etc/default/grub

## Disable halt on dirty reboot
sed -i 's/set timeout=-1/set timeout=${2}/' /etc/grub.d/00_header

## Enable the changes
update-grub

## Mount with noatime and enable trim
sed -i 's/errors=remount-ro/errors=remount-ro,noatime,discard/' /etc/fstab





## Powertop tweaks
## Massive powersaving -> 4 watts
aptitude install -y sysfsutils
#iw dev wlan0 set power_save on ## Kills wifi performance
/sbin/modprobe cpufreq_ondemand > /dev/null 2>&1
echo "kernel.nmi_watchdog = 0" > /etc/sysctl.d/disable_watchdog.conf
echo "vm.dirty_writeback_centisecs = 1500" > /etc/sysctl.d/dirty_writeback.conf
echo "proc.sys.vm.laptop_mode = 5" > /etc/sysctl.d/laptop_mode.conf
echo "module/snd_hda_intel/parameters/power_save = 1" >> /etc/sysfs.conf
echo "class/scsi_host/host0/link_power_management_policy = min_power" >> /etc/sysfs.conf
echo "bus/cpu/devices/cpu0/cpufreq/scaling_governor = ondemand" >> /etc/sysfs.conf
echo "bus/cpu/devices/cpu0/cpufreq/scaling_governor = ondemand" >> /etc/sysfs.conf
echo "bus/usb/devices/4-2/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/8-1/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb1/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb2/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb3/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb4/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb5/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb6/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb7/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb8/power/control = auto" >> /etc/sysfs.conf
echo "bus/usb/devices/usb9/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:12.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:13.2/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:12.2/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:13.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:16.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:11.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:04.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:01.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:06:00.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:07:00.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:03:00.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:15.2/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:14.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:15.0/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:14.5/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:14.1/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:01.1/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:15.3/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:16.2/power/control = auto" >> /etc/sysfs.conf
echo "bus/pci/devices/0000:00:18.3/power/control = auto" >> /etc/sysfs.conf




## Undervolting -> -10 watts under full load
wget http://switch.dl.sourceforge.net/project/undervolt/undervolt-0.4.tgz
tar -xzf undervolt-0.4.tgz 
rm undervolt-0.4.tgz 
cd undervolt-0.4/
make
cp undervolt /usr/bin/
cd ../
rm -rf undervolt-0.4/
echo "msr" >> /etc/modules
undervolt -p 0:0x22 -p 1:0x29 -p 2:0x3D
mv undervolt /etc/init.d/
update-rc.d undervolt defaults
echo "root ALL=NOPASSWD:/usr/bin/undervolt" > /etc/sudoers.d/undervolt

