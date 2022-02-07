set -e
sudo apt-get install python3-pip

free -m
sudo systemctl disable nvzramconfig
sudo fallocate -l 8G /mnt/8GB.swap
sudo chmod 600 /mnt/8GB.swap
sudo mkswap /mnt/8GB.swap
sudo vi /etc/fsatb 
/mnt/8GB.swap none swap sw 0 0 




sudo apt-get update
sudo apt install python3-pip
pip3 install Cython
export PATH=/usr/local/cuda/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
pip3 install 'pycuda>=2019.1.1'
pip3 install protobuf>=3.11.3
sudo apt-get install python3-pip protobuf-compiler libprotoc-dev
sudo pip3 install onnx==1.4.1
sudo apt-get install libjpeg-dev




