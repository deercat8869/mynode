简单测试一下node和docker

关于github用法，参见https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows

docker image list
docker image pull node

docker image build -t deercat/node:v01 .

docker container run deercat/node:v01

推送到网页端 https://hub.docker.com/repository
docker push deercat8869/mynode:tagname

#从网页端下载 https://hub.docker.com/repository
docker pull deercat8869/mynode:tagname

映射端口
docker container run -name myweb -d -p 8080:80 deercat/node:v01

启动nginx
docker container start myweb

关闭nginx
docker container stop myweb

列出所有容器
docker container ls -a

删除指定的容器
docker container rm -rf myweb

删除所有容器
docker container prune

*********************************
#随便执行linux几个命令
docker container run deercat/node:v01 node -v
docker container run deercat/node:v01 cat /etc/os-release

#进入点Dockerfile的配置
···
FROM node
ENTRYPOINT["node"]
CMD [""]
···
修改完要重新build

又一个docker的例子
···
FROM node
RUN mkdir /src
COPY hello.js /src
CMD ["node","/src/hello.js"]
···



*************************************************
sudo apt install openjdk-19-jdk
FROM ubuntu:22.04