## 安装运行环境依赖，自编译建议修改为国内镜像源
#sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
#sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
#sed -i 's/ports.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.aliyun.com@g" /etc/apt/sources.list

apt-get update
apt-get upgrade -y
apt-get install --no-install-recommends -y \
python3 \
python3-pip \
tesseract-ocr \
tesseract-ocr-eng \
tesseract-ocr-chi-sim \
language-pack-zh-hans \
sudo \
git \
openssl \
redis-server \
curl \
wget \
neofetch \
imagemagick \
ffmpeg \
fortune-mod \
figlet \
libmagic1 \
libzbar0 \
iputils-ping

## 设置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
## python软链接
ln -sf /usr/bin/python3 /usr/bin/python
## 升级pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python -m pip install --upgrade pip
## 添加用户
useradd auto_spy -u 917 -U -r -m -d /auto_spy -s /bin/bash
usermod -aG sudo,users auto_spy
echo "auto_spy ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/auto_spy




rm -rf /root/auto_spy
git clone -b master https://gitee.com/xxsc/auto_spy.git /root/auto_spy
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

cd /root/auto_spy
cp -r s6/* /
printf "请修改好配置文件中的TG参数，修改完成后输入 Y 进行登录 [Y/n] ："
read -r persistence <&1


