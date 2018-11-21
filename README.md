# prkotel

> A raspberry pi hardware part of kotel

## Build Setup

``` bash
# connect sensors
sudo modprobe w1-gpio && sudo modprobe w1_therm

# to /boot/config.txt add line: 
dtoverlay=w1-gpio

# set the camera module on in raspi-config

# instal package for adding a datetime to camera image
sudo apt-get install graphicsmagick-imagemagick-compat

#add line to crontab (for every minute)
* * * * * /path-to-exec-file/script.sh

```