#!/bin/bash
echo "Installing Arducam-Pivariety-V4L2-Driver..."
echo "--------------------------------------"
sudo install -p -m 755 ./arducam_camera_selector.sh /usr/bin/
sudo install -p -m 644 ./bin/$(uname -r)/arducam.ko  /lib/modules/$(uname -r)/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$(uname -r)/arducam.dtbo /boot/overlays/
uname=$(uname -r)
sudo install -p -m 644 ./bin/$uname/imx519.ko /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/ak7375.ko /lib/modules/$uname/kernel/drivers/media/i2c/ 
sudo install -p -m 644 ./bin/$uname/imx519.dtbo /boot/overlays/
sudo /sbin/depmod -a $(uname -r)
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

wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh
./install_pivariety_pkgs.sh -p libcamera_dev
./install_pivariety_pkgs.sh -p libcamera_apps

esac

        
