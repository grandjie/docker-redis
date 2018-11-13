#!/bin/bash

#redis工作目录,取第一个参数,否则默认pwd目录
workdir="${1:-$(pwd)}"
host_ip="$2"
echo "Redis work dir: ${workdir}"

#挂载目录是否存在
if [ ! -d ${workdir}/data ]; then
  mkdir ${workdir}/data
  chmod -R 777 ${workdir}/data
fi

#挂载目录是否可写
if [ ! -w ${workdir}/data ]; then
  chmod -R 777 ${workdir}/data
fi

if [ ! $host_ip ]; then
  #获取本机ip
  if [ $(which ip)]; then
    host_ip=$(ip route | awk '/default/ { print $9 }')
  else
    host_ip=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
  fi

  if [ ! ${host_ip} ]; then
    host_ip="127.0.0.1"
  fi
fi

echo "启动Redis cluster节点, 绑定Ip:${host_ip}, 挂载目录:${workdir}/data"

sudo docker run \
     -v ${workdir}/redis.conf:/usr/local/etc/redis/redis.conf \
     -v ${workdir}/data:/redis/ \
     --name redis \
     -d \
     --privileged=true \
     --rm \
     --net host \
     redis:5.0.1 redis-server /usr/local/etc/redis/redis.conf --bind ${host_ip}