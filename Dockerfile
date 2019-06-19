FROM benzbrake/alpine
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>

ARG FRP_VER=0.27.0
ENV FRP_BIND_PORT=7000

ADD frps.ini /etc/
RUN set -ex && \
	curl -sSL https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz -o /tmp/fprs.tgz && \
	cd /tmp && tar xvf /tmp/fprs.tgz &&\
	mv /tmp/frp_${FRP_VER}_linux_amd64/frps /usr/bin/ &&\
	rm -rf /tmp/frp_${FRP_VER}_linux_amd64
CMD ["-c", "/etc/frps.ini"]
ENTRYPOINT ["/usr/bin/frps"]