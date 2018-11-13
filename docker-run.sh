#!/bin/bash

 docker run \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -v ~/develop/xs1h/xsredis/:/bitnami/redis/data \
    bitnami/redis:latest