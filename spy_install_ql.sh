if [ ! -d /ql/scripts/spy ]; then
mkdir /ql/scripts/spy
fi

cd /ql/scripts/spy

if [ -d ./auto_spy/ ]; then
    rm -rf ./auto_spy
fi

git clone https://gitee.com/xxsc/auo-spy.git ./auto_spy
cp -rf ./auto_spy/* ./

if [ -f ./auto_spy.yaml ]; then
    echo "配置文件已存在，不复制示例配置"
else
    echo "第一次安装，复制示例配置"
    cp auto_spy_simple.yaml auto_spy.yaml
fi

