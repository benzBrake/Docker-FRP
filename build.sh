#!/bin/sh
apt-get update
apt-get -y install curl ca-certificates
cd /
architecture=""
case "$(uname -m)" in
i386) architecture="386" ;;
i686) architecture="386" ;;
x86_64) architecture="amd64" ;;
aarch64) architecture="arm64" ;;
arm*)
    if [ -z "$(echo ${architecture} | grep arm64)" ]; then
        architecture="arm"

    else
        architecture="arm64"
    fi
    ;;
esac
[ -z ${architecture} ] && exit 1
frp_version=$(curl -H 'Cache-Control: no-cache' -s https://api.github.com/repos/fatedier/frp/releases/latest | grep 'tag_name' | awk -F '[:,"v]' '{print $6}')
frp_download_url="https://github.com/fatedier/frp/releases/download/v${frp_version}/frp_${frp_version}_linux_${architecture}.tar.gz"
curl -sSL "${frp_download_url}" -o /frp.tar.gz
tar xvf /frp.tar.gz
cd "frp_${frp_version}_linux_${architecture}" || exit 1
mv frp* /
chmod +x /frp*
