FROM docker.io/library/golang as build
ARG BUILD_VERSION
ADD build.sh /build.sh
RUN mkdir -pv /go/src/github.com/fatedier
RUN set -x \
    && chmod +x /build.sh \
    && /build.sh
ENTRYPOINT ["bash"]

FROM scratch
MAINTAINER Ryan Lieu <github-benzBrake@woai.ru>
ENV FRP_BIND_PORT=7000
COPY --from=build /go/src/github.com/fatedier/frp/bin/frpc /usr/bin/frpc
RUN mkdir -p /etc/frp
ENTRYPOINT ["/usr/bin/frpc"]