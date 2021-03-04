#!/bin/sh
###
 # @Author: Ryan
 # @Date: 2021-02-22 16:08:35
 # @LastEditTime: 2021-03-04 18:54:51
 # @LastEditors: Ryan
 # @Description: Frp 服务端构建
 # @FilePath: \Docker-FRP\server\build.sh
###
uname -m
mkdir -pv /go/src/github.com/fatedier
go get github.com/tools/godep
cd /go/src/github.com/fatedier
git clone https://github.com/fatedier/frp frp
cd /go/src/github.com/fatedier/frp
git checkout ${BUILD_VERSION-master}
CGO_ENABLED=0 make frps
chmod +x /go/src/github.com/fatedier/frp/bin/frp
