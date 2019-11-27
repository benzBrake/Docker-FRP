#!/bin/sh
if [ -z ${BUILD_VERSION} ]; then 
    exit 1
fi
_LINK=$(curl --silent https://github.com/fatedier/frp/releases/${BUILD_VERSION} | grep "frp_.*_linux_amd64.tar.gz" | grep "<a" | awk -F'"' '{print $2}')
if [ -z ${_LINK} ]; then
    # 编译
    go get github.com/tools/godep
    cd /go/src/github.com/fatedier
    git clone https://github.com/fatedier/frp frp
    cd /go/src/github.com/fatedier/frp
    git checkout ${BUILD_VERSION-master}
    CGO_ENABLED=0 make frpc
    chmod +x /go/src/github.com/fatedier/frp/bin/frp
else
    # 下载二进制
    cd /tmp
    curl -sSL https://github.com${_LINK} -o frp.tar.gz
    tar zxvf frp.tar.gz
    rm -f frp.tar.gz
    mv frp* frp
    chmod +x /tmp/frp/frps
    mkdir -pv /go/src/github.com/fatedier/frp/bin/
    cp /tmp/frp/frpc /go/src/github.com/fatedier/frp/bin/
fi