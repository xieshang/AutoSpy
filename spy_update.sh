#!/bin/sh

apt install wget -y


pidfile_="auto_spy.so_aarch64"
if [ -f ${pidfile_} ]; then


echo "地址正确，开始强制升级"

rm auto_spy.so_aarch64*
rm auto_spy.so_x86_64*
rm auto_spy.so_x86_64_2*

wget https://github.com/xieshang/AutoSpy/raw/master/auto_spy.so_aarch64
wget https://github.com/xieshang/AutoSpy/raw/master/auto_spy.so_x86_64
wget https://github.com/xieshang/AutoSpy/raw/master/auto_spy.so_x86_64_2

echo "重启一下spy试试吧"


else

echo "地址不对，请在spy文件夹下运行"

fi

echo "运行结束"

