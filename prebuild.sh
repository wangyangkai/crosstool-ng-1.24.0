#!/bin/sh
#
# crosstool-ng-build-toolchain/prebuild.sh
#
# Author: Yangkai Wang <wang_yangkai@163.com>
#

DIR="$( cd "$( dirname "$0"  )" && pwd  )"
echo "shell pwd:$DIR"

CROSSTOLL_NG_VERSION="crosstool-ng-1.22.0"
PACKAGE=$CROSSTOLL_NG_VERSION".tar.bz2"
PACKAGE_URL="http://crosstool-ng.org/download/crosstool-ng/"$PACKAGE
echo "PACKAGE_URL:$PACKAGE_URL"

if [ ! -f "$PACKAGE" ]; then
	echo "wget -c $PACKAGE_URL -P $DIR/"
	wget -c $PACKAGE_URL -P $DIR/
fi

echo "tar -xvf PACKAGE -C $DIR/"
tar -xvf $DIR/$PACKAGE -C $DIR/

echo "mkdir $DIR/toolchain"
echo "mkdir $DIR/dl"
echo "mkdir $DIR/install"
mkdir $DIR/toolchain
mkdir $DIR/dl
mkdir $DIR/install

echo "cd $DIR/$CROSSTOLL_NG_VERSION"
cd $DIR/$CROSSTOLL_NG_VERSION
if [ $? -eq 0 ]; then
	echo "pwd:$PWD"
else
	cd $DIR/crosstool-ng
	echo "pwd:$PWD"
fi

echo "./configure --prefix=$DIR/install"
echo "make"
echo "make install"
./configure --prefix=$DIR/install
make
make install

export PATH="$PATH:$DIR/install/bin"
echo "PATH:$PATH"

ct-ng help
ct-ng list-samples

#ct-ng arm-cortex_a8-linux-gnueabi
#ct-ng build /* start build */
#mv $DIR/toolchain $DIR/arm-cortex_a8-linux-gnueabi-4.9.3
#tar -cvjf $DIR/arm-cortex_a8-linux-gnueabi-4.9.3.tar.bz2 $DIR/arm-cortex_a8-linux-gnueabi-4.9.3

#cd crosstool-ng
#./ct-ng list-samples
#./ct-ng arm-cortex_a8-linux-gnueabi
#./ct-ng menuconfig
#set Local tarballs directory:${CT_TOP_DIR}/../dl
#set Prefix directory:${CT_TOP_DIR}/../toolchain
#set Version of linux (3.2.72)
#mv toolchain arm-cortex_a8-linux-gnueabi-4.9.3
#tar -cvjf arm-cortex_a8-linux-gnueabi-4.9.3.tar.bz2 arm-cortex_a8-linux-gnueabi-4.9.3

