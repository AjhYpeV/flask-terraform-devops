provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow HTTP inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask_app" {
  ami           = "ami-0437df53acb2bbbfd"
  instance_type = "t3.micro"
  key_name      = var.key_name
  user_data     = file("user_data.sh")

  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  tags = {
    Name = "FlaskApp"
  }
}
