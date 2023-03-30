#!/bin/bash

get_arch=`uname -m`
if [[ $get_arch == "x86_64" ]];then
    arch='x86'
elif [[ $get_arch == "aarch64" ]];then
    arch='arm'
elif [[ $get_arch == "mips64" ]];then
    arch='x86'
elif [[ $get_arch == "i686" ]];then
    arch='x86'
else
    echo "unknown!!"
    exit 0 
fi
if [[ $(docker ps|grep auto_spy|awk '{print $10}') == "auto_spy" ]]; then
	echo "登录成功后，请按CTRL+C退出"
	docker exec -it auto_spy bash /autospy/start.sh
	echo "重启容器，spy将自动重启"
	docker restart auto_spy
	echo -e "快去发送spy看看吧，如果出错，请确认自己的任务列表是否正确\n输入 docker logs auto_spy 查看运行日志\n"	
	exit 0
fi
if [[ -d "$(pwd)"/auto_spy_data/autospy  ]]; then
	docker stop auto_spy
	docker rm auto_spy
	echo "autospy配置文件已存在"
	docker run -dit --restart=always --name=auto_spy --log-opt max-size=100m --log-opt max-file=3 -v "$(pwd)"/auto_spy_data/autospy:/autospy --hostname=auto_spy xieshang1111/auto_spy:$arch
else
	mkdir auto_spy_data
    docker run -dit --restart=always --name=auto_spy --hostname=auto_spy xieshang1111/auto_spy:$arch
	docker cp auto_spy:/autospy/ "$(pwd)"/auto_spy_data/autospy
	docker stop auto_spy
	docker rm auto_spy	
	echo -n -e "检测到autospy配置文件不存在，如之前直装过auto_spy,请输入绝对路径以完成配置文件一键迁移(如没安装过，直接回车即可)："
	read dir
	if [[ $dir != "" ]];then
	docker run -dit --restart=always --name=auto_spy --log-opt max-size=100m --log-opt max-file=3 -v "$(pwd)"/auto_spy_data/autospy:/autospy --hostname=auto_spy xieshang1111/auto_spy:$arch
	cp $dir/auto_spy.yaml "$(pwd)"/auto_spy_data/autospy
	docker exec -it auto_spy bash /autospy/start.sh
	exit 0
else
	mkdir auto_spy_data
	docker cp auto_spy:/autospy/ "$(pwd)"/auto_spy_data/autospy
	docker stop auto_spy
	docker rm auto_spy
	docker run -dit --restart=always --name=auto_spy --log-opt max-size=100m --log-opt max-file=3 -v "$(pwd)"/auto_spy_data/autospy:/autospy --hostname=auto_spy xieshang1111/auto_spy:$arch
	cp "$(pwd)"/auto_spy_data/autospy/auto_spy_simple.yaml "$(pwd)"/auto_spy_data/autospy/auto_spy.yaml
	echo -e "现在可以去目录下[auto_spy_data/auto_spy]里的[auto_spy.yaml]修改信息了\n修改完成后，请再次运行脚本\n"
	exit 0
    fi
fi