#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -aG docker ec2-user
sudo systemctl enable docker

# Wait for docker to be ready
sleep 30

# Pull and run the container
sudo docker run -d -p 80:5000 --name flask-app --restart unless-stopped ghcr.io/ajhypev/flask-terraform-devops/flask-app:latest
