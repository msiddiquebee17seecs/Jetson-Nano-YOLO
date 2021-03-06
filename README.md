# Jetson-Nano-Yolo
This repository contains all files and explanation to run yolo model on Jetson nano. YOLO is object detector which is trained on COCO dataset with 80 different classes.

-Following are the steps to deploy this model on Jetson Nano.

**Setting up Jetson Nano**

- Download SD Card image for your Jetson Nano from https://developer.nvidia.com/embedded/downloads.
- Format SD card using SD card formatter. You can download it from https://www.sdcard.org/downloads/formatter/sd-memory-card-formatter-for-windows-download/
- Make sure you have Balena etcher installed on your machine to flash SD Card otherwise download it from https://www.balena.io/etcher/.
- Flashing will take few minutes as it will be two step process   1) Flashing      2)Validation
- Insert card in jetson nano and follow steps.


**Initial packages/Libraries**
- Clone this repository

``` 
$ cd ${HOME}/project
$ git clone https://github.com/msiddiquebee17seecs/Jetson-Nano-YOLO.git
$ cd Jetson-Nano-YOLO
```

- Assuming this repository has been cloned at "${HOME}/projectJetson-Nano-Yolo", follow these steps:
- First thing to install is the pip3 tool, which will be used to install Python Packages later on.
- Use these commands in terminal to install pip3
- ```sudo apt-get update```
- ```sudo apt-get install python3-pip```


***Make swap memory using following commands***
```free -m
sudo systemctl disable nvzramconfig
sudo fallocate -l 8G /mnt/8GB.swap
sudo chmod 600 /mnt/8GB.swap
sudo mkswap /mnt/8GB.swap
sudo vi /etc/fsatb 

Press :i to insert follwing line in /etc/fstab andthen press :wq to save and exit

/mnt/8GB.swap none swap sw 0 0 
```
- Reboot system and then verify swap memory using ```free -m```
- Make sure the swap space gets mounted automatically after reboot.


***Other packages***
- We need to setup environment and install few libraries like pycuda etc required for CUDA and GPU accelerations .
- For installing these libraries run

```
$ cd ${HOME}/project/Jetson-Nano-YOLO/yolo
sudo sh ./initial_cmd.sh
sudo sh ./install_pycuda.sh
````  

- If there is any issue refer to Demo 5 yolov4 on https://github.com/jkjung-avt/tensorrt_demos by @jkjung-avt.




**YOLO Demonstration**
- Make sure you have installed  correct version of pycuda and onnx.
- Go to ```$ cd ${HOME}/project/Jetson-Nano-YOLO/plugins``` folder and edit "Makefile" in text editor
- Chnage NVCC=nvcc to ```NVCC=/usr/local/cuda/bin/```
- Now build the "yolo_layer" plugin using following command. When done, a "libyolo_layer.so" would be generated.
 ```
$ cd ${HOME}/project/Jetson-Nano-YOLO/plugins
$ sudo make
```  
- Download weight and cfg files of your desired yolo version or use ```./download_yolo.sh```.It will download weight and cfg files of different pretrained yolo versions.
```
$ cd ${HOME}/project/Jetson-Nano-YOLO/yolo
sudo sh ./download_yolo.sh
```
- Now convert YOLO/COCO models to onnx format using ```yolo_to_onnx.py``` script.
```
$ cd ${HOME}/project/Jetson-Nano-YOLO/yolo
$ python3 yolo_to_onnx.py -m [model]
```  
- After this step onnx file will be generated {weightfile name].onnx

- Next convert onnx to trt format using ```onnx_to_tensorrt.py``` script.
```
$ cd ${HOME}/project/Jetson-Nano-YOLO/yolo
$ python3 onnx_to_tensorrt.py-m [model]
```

- After this stepoptimized trt file will be generated {weightfile name].trt
- NOTE: ONNX and TRT step could take half an hour Jetson Nano.

- Now we are done and ready to test our model with script ``trt_yolo.py```

```
$ cd ${HOME}/project/Jetson-Nano-YOLO
$ python3 trt_yolo.py --image cd ${HOME}/project/Jetson-Nano-YOLO/test.jpg -m [model]
```

- Moreover the following inputs could be specified:

- --image test_image.jpg: an image file, e.g. jpg or png.
- --video test_video.mp4: a video file, e.g. mp4 or ts. An optional --video_looping flag could be enabled if needed.
- --usb 0: USB webcam (/dev/video0).
- --rtsp rtsp://admin:123456@192.168.1.1/live.sdp: RTSP source, e.g. an IP cam. An optional --rtsp_latency argument could be used to adjust the latency setting in this case.
- --onboard 0: Jetson onboard camera

**Results**

- I tested two models and have achievd following results on Jetson Nano
- yolov4-416 ~3FPS
- yolov4-tiny-288 ~26FPS



![0725cc64-0967-4f68-9a63-336a934184a5](https://user-images.githubusercontent.com/82385991/152836059-ec32da15-fdbe-4513-a5c4-6e7eb1742e49.jpg)


