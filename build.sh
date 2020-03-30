#!/bin/bash

cd /root/sources

rootpath=$(pwd)
echo $rootpath

if [ -d ffmpeg ]; then
	rm -rf ffmpeg
fi

# echo "uncomparing ffmpeg.tar.gz"
# tar -zxf ffmpeg-n4.1.5.tar.gz
# cd ffmpeg
# ./configure --prefix=/toolchain/ffmpeg \
# 	--disable-static \
# 	--enable-shared \
# 	--disable-x86asm \
# 	--enable-cross-compile \
# 	--arch=arm \
# 	--target-os=linux \
# 	--cross-prefix=arm-linux-gnueabihf- \
# 	--cc=arm-linux-gnueabihf-gcc \
# 	--enable-pthreads \
# 	--enable-ffplay

# make -j 4 && make install
# cd ..

export PKG_CONFIG_PATH=/toolchain/ffmpeg/lib/pkgconfig:$PKG_CONFIG_PATH

if [ ! -d opencv ]; then
	echo "uncomparing opencv.tar.gz"
	tar -zxf opencv-4.2.0.tar.gz
fi

# 编译opencv
cd opencv 

# 创建输出目录
rm -rf build && mkdir build && cd build

cmake \
	-D ENABLE_NEON=ON \
	-D ENABLE_VFPV3=ON \
	-D WITH_FFMPEG=ON \
	-D ARM_LINUX_SYSROOT=/toolchain/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64 \
	-D CMAKE_TOOLCHAIN_FILE=$rootpath/opencv/platforms/linux/arm-gnueabi.toolchain.cmake \
	-D CMAKE_CXX_FLAGS="-O2 -pipe -mcpu=arm1176jzf-s -mfpu=vfp -mfloat-abi=hard -w" \
	-D CMAKE_BUILD_TYPE=Release \
	-D CMAKE_INSTALL_PREFIX=/toolchain/opencv \
	..
make -j8 && make install




