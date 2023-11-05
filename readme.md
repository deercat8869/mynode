简单测试一下node和docker

关于github用法，参见https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows

docker image list
docker image pull node

docker image build -t deercat/node:v01 .

docker container run deercat/node:v01

推送到网页端 https://hub.docker.com/repository
docker push deercat8869/mynode:tagname

从网页端下载 https://hub.docker.com/repository
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
随便执行linux几个命令
docker container run deercat/node:v01 node -v
docker container run deercat/node:v01 cat /etc/os-release

#进入点Dockerfile的配置
```
FROM node
ENTRYPOINT["node"]
CMD [""]
```
修改完要重新build

又一个docker的例子
```
FROM node
RUN mkdir /src
COPY hello.js /src
CMD ["node","/src/hello.js"]
```



*************************************************
做一个开发环境试试
```
FROM ubuntu:22.04
MAINTAINER deercat8869
WORKDIR /home
RUN apt-get update \
	&& apt-get install -y --no-install-recommends openjdk-19-jdk \	
	&& apt-get install -y --no-install-recommends mysql-server-8.0 \
    && apt-get install -y --no-install-recommends nginx-core \
    && apt-get install -y --no-install-recommends maven \
    && apt-get clean

docker image build -t deercat8869/java_mysql:v01 .    
```

配置数据库
参考https://blog.csdn.net/lianghecai52171314/article/details/113807099
```
初始化
sudo mysql_secure_installation
查看状态
systemctl status mysql.service
重启mysql
sudo /etc/init.d/mysql restart

登录
sudo mysql -uroot -p

use mysql;
ALTER USER 'root’@‘localhost' IDENTIFIED WITH mysql_native_password BY '123456';
ALTER USER 'root’@‘localhost' IDENTIFIED BY '123456' PASSWORD EXPIRE NEVER; 
update user set host='%' where user='root';
flush privileges;

sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 3306 -j ACCEPT

```