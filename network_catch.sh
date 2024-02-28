#!/bin/bash

# 检查是否提供了容器ID作为参数
if [ -z "$1" ]; then
    echo "Usage: $0 <container-id>"
    exit 1
fi

# 获取容器的PID
container_id="$1"
pid=$(docker inspect -f '{{.State.Pid}}' "$container_id")

# 检查是否成功获取PID
if [ -z "$pid" ]; then
    echo "Failed to get PID for container $container_id"
    exit 1
fi

# 执行nsenter并输入密码123
sudo nsenter -t "$pid" -n

tcpdump -i eth0 -w ./result.pcap