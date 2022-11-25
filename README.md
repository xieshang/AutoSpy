# auto_spy

## 介绍
简单介绍一下SPY的功能：
**监听**（跟傻妞的SPY一样）：自动监听设置好的频道或群，捕捉关键词，并转换成你脚本对应的环境变量，自动启动对应的任务

**队列**：当瞬间涌入多个同一脚本变量时，自动进入队列，当前面一个跑完，根据设置延时，自动跑下一个变量，有限抢占最新变量，并且不会遗漏线报做到捡漏；

**多频道**：每个频道线报优势均有所不同，SPY支持多频道监听，不同变量自动转换成脚本对应环境变量，实现多频道自动监听；

**去重**：多个频道线报有先后，内容有重复，SPY自动去重，防止跑无用线报内容，抢占第一手脚本运行；

**多任务**：每个脚本对应一个任务，均采用多线程管理，独立运行，互不干扰；

**不易黑IP**：因为是队列，每次跑的间隔自行设置，所以只要调整得当，不易黑IP，当然脚本造成的黑没有办法；



## 安装教程

参考教程1（faker写的）：https://thin-hill-428.notion.site/Spy-abac16b82bec43c3845071b8fe81361f

参考教程2（小白照着faker教程写的）：https://www.kejiwanjia.com/jiaocheng/115954.html

下面是我写的简要教程：

```
新装的自己按这个流程摸索吧：

准备好以下东西：

* 可以访问的青龙ip、id、密钥
* spy授权码，没有授权的申请试用，在群内发送[/spy 试用]和[/spy 授权]即可获取授权码，超级授权也用试用授权码
* 一个外国籍服务器，国内的自己想办法折腾
* 加入spy授权群，否则无法完成授权功能
https://t.me/spy_auth


开始：

1、一键，运行一次就行，那个登录的时候ctrl+c跳过：
wget -O autospy https://raw.githubusercontent.com/xieshang/AutoSpy/master/docker.sh && chmod +x autospy && ./autospy

进入容器：
docker exec -it auto_spy bash
 
强制升级：
bash <(curl -s -L https://raw.githubusercontent.com/xieshang/AutoSpy/master/spy_update.sh)


3、登录

1、把启动脚本换个名字
docker exec -it auto_spy bash
mv auto_spy_bot.py auto_spy_bot2.py
exit

2、重启容器，使之不自动启动
docker restart auto_spy

3、手动启动
docker exec -it auto_spy bash
pip uninstall telethon
pip install telethon==1.24.0
pip3 install --user snowland-smx

调试启动:
python3 auto_spy_bot2.py

登录，改配置测试，直到你满意为止

后台启动:
python3 auto_spy_bot2.py &

4、没问题了，换回自动启动
mv auto_spy_bot2.py auto_spy_bot.py
exit

docker restart auto_spy
```

## SPY指令

1、spy ?：查看spy支持的指令列表

2、**spy**：查看队列情况，10秒后自动撤回；
3、**spy 重启**：重启SPY；
4、**spy 升级**：升级到最新的SPY；

........


## 问题排查
* 登录TG的时候没跳出来要求输入电话？
```
请确认配置文件的API和hash是否填写正确；
```

* 发spy没反应？
```
1、确认masterid是不是你自己的？
2、spy有没有在运行呢？如果是screen后台
```

