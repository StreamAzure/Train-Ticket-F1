#!/bin/bash

# Set the kind cluster name
CLUSTER_NAME="kind"

# Set the prefix for your Docker images
IMAGE_PREFIX="codewisdom/ts-"

# Set the tag for your Docker images
IMAGE_TAG="v1"

# List all image tags matching the specified prefix and tag
IMAGE_TAGS=$(docker images -q --format "{{.Repository}}:{{.Tag}}" ${IMAGE_PREFIX}*:${IMAGE_TAG})

# Load each image into the kind cluster
for TAG in $IMAGE_TAGS; do
  echo "Loading image: $TAG"
  kind load docker-image $TAG --name $CLUSTER_NAME
done

# 指定要导入的一系列镜像名称
IMAGE_NAMES="redis mysql:5.6.35 ts-verification-code-service-with-jaeger:NO_VER jaegertracing/all-in-one:1.15"
kind load docker-image $IMAGE_NAMES --name $CLUSTER_NAME

# 显示已导入的镜像
docker exec -it kind-control-plane crictl images
