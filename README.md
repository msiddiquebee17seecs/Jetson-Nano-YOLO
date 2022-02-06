# Jetson-Nano-Yolo
This repository contain all files and explanation to run yolo model on Jetson nano. YOLO is object detector which is trained on COCO dataset with 80 different classes.

-Follwing are the steps to deploy this model on jetson nano.

**#Setting up Jetson Nano**
>
- Download SD Card image for your Jetson Nano from https://developer.nvidia.com/embedded/downloads.
- Format SD card using SD card formatter. You can download it from https://www.sdcard.org/downloads/formatter/sd-memory-card-formatter-for-windows-download/
- Make sure you have Balena etcher installed on your machine to flash SD Card otherwuse download it from https://www.balena.io/etcher/.
- Flashing will take few minutes as it will be two step process   1) Flashing      2)Validation
- Insert card in jetson nano and follow steps. Dont forget to make swap memory while setting up jetson nano.
>

**Initial packages/Libraries**
- After flashing, first thing to install is the pip3 tool, which will be used to install Python Pakages later on 
- Use this command in terminal ```sudo apt-get install python3-pip```
- If you forgot to make swap menory use this command to set it up before installing other libraries.
```$ sudo fallocate -l 8G /mnt/8GB.swap
$ sudo mkswap /mnt/8GB.swap
$sudo swapon /mnt/8GB.swap
```
- Once the above is working, add the following line```/mnt/8GB.swap  none  swap  sw 0  0``` into ```/etc/fstab``` and reboot the system.
- Make sure the swap space gets mounted automatically after reboot.


