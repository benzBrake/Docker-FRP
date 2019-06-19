# Docker-FRP

This is possible thanks to the work from [fatedier](https://github.com/fatedier) on project [frp](https://github.com/fatedier/frp).

#### What is frp?

frp is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet. As of now, it supports tcp & udp, as well as http and https protocols, where requests can be forwarded to internal services by domain name.

## How to use this image

### Run frp server

Just run this command to use frps:

```shell
docker run --rm --name frps –net=host -e FRP_BIND_PORT="7000" benzbrake/frps
```

Or using your own config file:

```shell
docker run --rm --name frps –net=host -v /path/to/frps.ini:/etc/frps.ini benzbrake/frps
```

[full frps.ini readme](https://github.com/fatedier/frp/blob/master/README.md)

## 中文使用说明

### 运行FRP服务器

直接运行

```shell
docker run --rm --name frps –net=host benzbrake/frps
```

若需要修改默认端口

```shell
docker run --rm --name frps –net=host -e FRP_BIND_PORT="7000" benzbrake/frps
```

自定义配置文件

```shell
docker run --rm --name frps –net=host -v /path/to/frps.ini:/etc/frps.ini benzbrake/frps
```

### 群晖使用

搜索注册表benzbrke/frps，Tags 选择你要安装的版本下载

高级设置-卷-添加文件 本地文件自选（本地frps.ini），装载路径 /etc/frps.ini （装载路径不能修改）

[frps.ini 详细说明](https://github.com/fatedier/frp/blob/master/README.md)

## License

Copy as you want. 随你便