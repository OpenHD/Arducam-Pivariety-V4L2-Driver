#!/bin/bash


install_drivers() {
echo "Installing Arducam-Pivariety-V4L2-Driver..."
echo "--------------------------------------"
sudo install -p -m 755 ./arducam_camera_selector.sh /usr/bin/
sudo install -p -m 644 ./bin/$uname/arducam.ko  /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/arducam.dtbo /boot/overlays/
sudo install -p -m 644 ./bin/$uname/imx519.ko /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/ak7375.ko /lib/modules/$uname/kernel/drivers/media/i2c/ 
sudo install -p -m 644 ./bin/$uname/imx519.dtbo /boot/overlays/
sudo /sbin/depmod -a $uname
}

uname="5.15.61-v7+"
install_drivers

uname="5.15.61-v7l+"
install_drivers

uname="5.15.61-v8+"
install_drivers

uname="5.15.61+"
install_drivers

    #uname=$(uname -r)
    #install_drivers();


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

#Install new Libcamera
echo -e "remove libcamera0"
echo ""
sudo apt remove -y libcamera0
sudo apt install -y ../libcamera-bins/libcamera-dev-0.0.10-bullseye-armhf.deb
sudo apt install -y ../libcamera-bins/libcamera-apps-0.0.10-bullseye-armhf.deb


        
