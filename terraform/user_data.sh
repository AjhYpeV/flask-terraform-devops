#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -aG docker ec2-user
systemctl enable docker

# Wait for docker to be ready
sleep 30

# Pull and run the container
docker run -d -p 80:5000 --name flask-app --restart unless-stopped ghcr.io/ajhypev/flask-app:latest
