#!/bin/sh
mkdir -pv /go/src/github.com/fatedier
go get github.com/tools/godep
cd /go/src/github.com/fatedier
git clone https://github.com/fatedier/frp frp
cd /go/src/github.com/fatedier/frp
git checkout ${BUILD_VERSION-master}
CGO_ENABLED=0 make frps
chmod +x /go/src/github.com/fatedier/frp/bin/frp
