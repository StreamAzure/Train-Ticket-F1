本项目为旧版 Train Ticket：https://gitee.com/yttty/train-ticket/tree/master/

已做的修改：
- ts-verification-code-service 替换为 jaeger-ty-no-veri-code 分支的同名目录，固定每次的验证码都为AAAA
- deployment/docker-compose-manifests/docker-compose-with-jaeger.yaml 中的 image: mongo 全部替换为 image: mongo:3.4.3
- 所有的 dockerfile 中的 From java:8-jre 替换为 FROM openjdk:8-jre 

---
以下构建为 with-jaeger 版本

编译构建：
需要 java8 和 maven
1. mvn clean package -Dmaven.test.skip=true
2. 构建新的 ts-verification-code-service 镜像，并命名为 ts-verification-code-service-with-jaeger:NO_VER
    ```
    cd ts-verification-code-service
    docker build -t ts-verification-code-service-with-jaeger:NO_VER .
    ```
3. 将 deployment/docker-compose-manifests/docker-compose-with-jaeger.yaml 中 ts-verification-code-service 的 image 替换为刚才构建的 ts-verification-code-service-with-jaeger:NO_VER
4. 启动：docker-compose -f deployment/docker-compose-manifests/docker-compose-with-jaeger.yml up -d

---
k8s 启动：
1. deployment/kubernetes-manifests/quickstart-k8s 下：
    - 有 image: mongo 的地方全部改为 image: mongo:3.4.3
    - part1 中的 image: jaegertracing/all-in-one 改为 image: jaegertracing/all-in-on:1.15
    - part2 中将 ts-verification-code-service 的镜像改为 image: ts-verification-code-service-with-jaeger:NO_VER
2. 载入镜像到 kinD
    ./load_images2kind.sh
3. 部署在 kind 中： 
    cd deployment/kubernetes-manifests/k8s-with-jaeger
    kubectl apply -f ts-deployment-part1.yml
    kubectl apply -f ts-deployment-part2.yml
    kubectl apply -f ts-deployment-part3.yml