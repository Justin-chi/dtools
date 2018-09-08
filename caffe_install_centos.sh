#!/bin/bash

WORKSPACE="$1"
echo "$WORKSPACE"
sudo yum install protobuf-devel leveldb-devel snappy-devel opencv-devel boost-devel hdf5-devel -y

sudo yum install openblas-devel.x86_64 gcc-c++.x86_64 numpy.x86_64 scipy.x86_64 python-matplotlib.x86_64 lapack-devel.x86_64 python-pillow.x86_64 libjpeg-turbo-devel.x86_64 freetype-devel.x86_64 libpng-devel.x86_64 openblas-devel.x86_64 -y

sudo yum install gflags-devel glog-devel lmdb-devel -y

yum install git -y

pushd ${WORKSPACE}

git clone https://github.com/BVLC/caffe.git

wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py 
python ez_setup.py --insecure

wget https://bootstrap.pypa.io/get-pip.py

python get-pip.py

cd caffe/python

for req in $(cat requirements.txt); do pip install $req; done

