#!/bin/bash

CHROOT=$1

if [[ $CHROOT == 1 ]]
then
    uname="5.15.61-v7+"
elif [[ $CHROOT == 2 ]]
then
    uname="5.15.61-v7l+"
elif [[ $CHROOT == 2 ]]
then
    uname="5.15.61-v8+"
elif [[ $CHROOT == 3 ]]
then
    uname="5.15.61+"
elif [[ $CHROOT == 0 ]]
then
    uname=$(uname -r)
fi

echo "Installing Arducam-Pivariety-V4L2-Driver..."
echo "--------------------------------------"
sudo install -p -m 755 ./arducam_camera_selector.sh /usr/bin/
sudo install -p -m 644 ./bin/$uname/arducam.ko  /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/arducam.dtbo /boot/overlays/
sudo install -p -m 644 ./bin/$uname/imx519.ko /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/ak7375.ko /lib/modules/$uname/kernel/drivers/media/i2c/ 
sudo install -p -m 644 ./bin/$uname/imx519.dtbo /boot/overlays/
sudo /sbin/depmod -a $uname
awk 'BEGIN{ count=0 }       \
{                           \
    if($1 == "dtoverlay=arducam-pivariety"){       \
        count++;            \
    }                       \
}END{                       \
    if(count <= 0){         \
        system("sudo sh -c '\''echo dtoverlay=arducam-pivariety >> /boot/config.txt'\''"); \
    }                       \
}' /boot/config.txt

awk 'BEGIN{ count=0 }       \
{                           \
    if($1 == "dtoverlay=imx519"){       \
        count++;            \
    }                       \
}END{                       \
    if(count <= 0){         \
        system("sudo sh -c '\''echo dtoverlay=imx519 >> /boot/config.txt'\''"); \
    }                       \
}' /boot/config.txt

#Install new Libcamera
echo -e "remove libcamera0"
echo ""
sudo apt remove -y libcamera0
sudo dpkg -i ../libcamera-bins/libcamera-dev-0.0.9-bullseye-armhf.deb

        
