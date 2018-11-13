FROM redis:5.0.1
LABEL Name=xsredis Version=0.0.1
#RUN sysctl -w net.core.somaxconn=65535
#RUN echo 65535 > /wproc/sys/net/core/somaxconn
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]