FROM benzbrake/alpine
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>

ARG FRP_VER=0.12.0

RUN set -ex && \
	curl -sSL https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz -o /tmp/fprs.tgz && \
	cd /tmp && tar xvf /tmp/fprs.tgz &&\
	mv /tmp/frp_${FRP_VER}_linux_amd64/frpc /usr/bin/ &&\
	rm -rf /tmp/frp_${FRP_VER}_linux_amd64

VOLUME /etc/frpc.ini
CMD ["-c", "/etc/frpc.ini"]
ENTRYPOINT ["/usr/bin/frpc"]