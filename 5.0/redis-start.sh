#!/bin/bash

#Redis cluster启动脚本
#redis.conf已在Dockerfile打包, 路径为/usr/local/etc/redis/redis.conf
#workdir为~/redis/
#注意!!默认挂载目录为workdir/data, 请确保该目录有所有写的权限

#workdir为~/redis/
workdir=$(echo ~)/redis
#获取本机默认网卡地址
host_ip=$(ip route | awk '/default/ { print $9 }')
#redis挂载目录, 默认为home/data
mount_dir=$(echo ~)/redis/data

echo "启动Redis cluster节点, 绑定Ip:${host_ip}, 挂载目录:${mount_dir}"

sudo docker run \
     -v ${workdir}/redis.conf:/usr/local/etc/redis/redis.conf \
     -v ${mount_dir}:/redis/ \
     -d \
     --name redis \
     --privileged=true \
     --rm \
     --net host \
     redis:5.0.1 redis-server /usr/local/etc/redis/redis.conf --bind ${host_ip}