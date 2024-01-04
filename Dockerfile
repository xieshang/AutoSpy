FROM python:3.6.15-slim-buster
ARG S6_VERSION=v2.2.0.3
ARG S6_ARCH=amd64
# ARG S6_ARCH=aarch64
ARG DEBIAN_FRONTEND=noninteractive
ARG USER_NAME=autospy
ARG WORK_DIR=/autospy
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    SHELL=/bin/bash \
    LANG=zh_CN.UTF-8 \
    PS1="\u@\h:\w \$ " \
    RUN_AS_ROOT=true
SHELL ["/bin/bash", "-c"]
WORKDIR $WORK_DIR
ENV LANG C.UTF-8
COPY . $WORK_DIR
RUN pwd && ls
RUN source ~/.bashrc \
    && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt update \
    && apt upgrade -y \
    && apt install --no-install-recommends -y \
    #    git \
        openssl \
        curl \
        wget \
        imagemagick \
    ## 安装s6 https://pd.zwc365.com/seturl/   https://gh.xiu.workers.dev/
    && curl -L -o /tmp/s6-overlay-installer https://github.jd-vip.tk/https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}-installer \
    && chmod +x /tmp/s6-overlay-installer \
    && /tmp/s6-overlay-installer / \
    ## 安装编译依赖
    && apt update \
    ## 设置时区
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    ## 升级pip
   && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && python -m pip install --upgrade pip \
    ## 克隆仓库
    ## && git clone --depth=1 -b master https://github.jd-vip.tk/https://github.com/xieshang/AutoSpy.git $WORK_DIR \
    && pwd && rm -rf .git \
    ## 复制s6启动脚本
    && cp -r s6/* / \
    && apt clean -y
RUN pwd && ls
ENTRYPOINT ["/init"]