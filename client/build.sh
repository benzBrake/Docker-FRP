#!/bin/sh
###
 # @Author: Ryan
 # @Date: 2021-02-22 16:08:35
 # @LastEditTime: 2021-03-04 18:55:27
 # @LastEditors: Ryan
 # @Description: Frp 客户端构建
 # @FilePath: \Docker-FRP\client\build.sh
### 
uname -m
mkdir -pv /go/src/github.com/fatedier
go get github.com/tools/godep
cd /go/src/github.com/fatedier
git clone https://github.com/fatedier/frp frp
cd /go/src/github.com/fatedier/frp
git checkout ${BUILD_VERSION-master}
CGO_ENABLED=0 make frpc
chmod +x /go/src/github.com/fatedier/frp/bin/frp
