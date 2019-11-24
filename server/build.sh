#!/bin/sh
if [[ -z ${BUILD_VERSION} ]]; then 
    exit 1
fi
BUILD_VERSION=v0.14.1
_LINK=$(curl --silent https://github.com/fatedier/frp/releases/${BUILD_VERSION} | grep frp_.*_linux_amd64.tar.gz | grep "<a" | awk -F'"' '{print $2}')
if [[ -z ${_LINK} ]]; then
    # 编译
    mkdir -pv /go/src/github.com/fatedier
    cd /go/src/github.com/fatedier
    git clone https://github.com/fatedier/frp frp
    cd /go/src/github.com/fatedier/frp
    git checkout ${BUILD_VERSION-master}
    CGO_ENABLED=0 make frps
    chmod +x /go/src/github.com/fatedier/frp/bin/frp
else
    # 下载二进制
    go get github.com/tools/godep
    curl -sSL https://github.com${_LINK} -o frp.tar.gz
    tar xvf frp.tar.gz
    rm -f frp.tar.gz
    mv frp* frp
    chmod +x /tmp/frp/frps
    mkdir /go/src/github.com/fatedier/frp/bin/
    cp /tmp/frp/frps /go/src/github.com/fatedier/frp/bin/
fi