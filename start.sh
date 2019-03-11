#/bin/bash

nginx_v=nginx:v1
new_nginx_v=noway56/nginx:latest

docker build -t ${nginx_v} .
docker tag ${nginx_v} ${new_nginx_v}
docker image rm ${nginx_v}

ip=`ifconfig eth0 |grep "inet addr"|awk -F: '{print $2}'|awk '{print $1}'`
docker swarm leave --force
docker swarm init --advertise-addr ${ip}
docker stack deploy -c docker-compose-stack.yml nginx
