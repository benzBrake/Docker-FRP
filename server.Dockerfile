FROM benzbrake/alpine as build
ARG BUILD_VERSION
ADD build.sh /build.sh
RUN mkdir -pv /go/src/github.com/fatedier
RUN set -x \
    && chmod +x /build.sh \
    && /build.sh
ENTRYPOINT ["bash"]

FROM scratch
LABEL maintainer="Lieu Ryan github-benzBrake@woai.ru"
ENV FRP_BIND_PORT=7000
EXPOSE 7000
COPY --from=build /frps /usr/bin/frps
COPY --from=build /frps.ini /frps.ini
CMD ["-c", "/frps.ini"]
ENTRYPOINT ["/usr/bin/frps"]