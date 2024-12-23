provider "aws" {
  region = var.region  # Use region from variables
}

resource "aws_instance" "my_instance" {
  ami             = var.ami_id  # Use AMI ID from variables
  instance_type   = var.instance_type  # Use instance type from variables
  key_name        = var.key_name  # Use the key name from variables
  security_groups = [aws_security_group.sg.name]

  # User data to install Docker and deploy application
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              systemctl enable docker
              docker pull ${var.docker_image}
              docker run -d -p ${var.docker_port}:${var.docker_port} --name ${var.docker_container_name} ${var.docker_image}
              EOF

  tags = {
    Name = "MyDockerAppInstance"
  }
}

resource "aws_security_group" "sg" {
  name        = "my-sg"
  description = "Allow inbound HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
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

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_public_dns" {
  value = aws_instance.my_instance.public_dns
}
