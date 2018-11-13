#!/bin/bash
docker build -t r1 .;
docker run \
--name redis \
--rm \
-v /Users/niyao/develop/xs1h/xsredis/vol:/redis \
--privileged \
-p 6379:6379 \
r1 \
/bin/bash -c 'echo 1024 > /proc/sys/net/core/somaxconn ; \
  echo never > /sys/kernel/mm/transparent_hugepage/enabled ; \
  redis-server /usr/local/etc/redis/redis.conf'