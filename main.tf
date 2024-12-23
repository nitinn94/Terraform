provider "aws" {
  region = "us-east-1"  # Choose your AWS region
}

resource "aws_instance" "my_instance" {
  ami             = var.ami             # Reference the variable for AMI
  instance_type   = var.instance_type   # Reference the variable for instance type
  key_name        = var.key_name        # Reference the variable for key name
  security_groups = [aws_security_group.sg.name]

  # User data to install Docker, start Docker service, and deploy nginx container
  user_data = <<-EOF
              #!/bin/bash
              # Update Ubuntu package list
              apt-get update -y
              # Install Docker
              apt-get install docker.io -y
              # Start Docker service
              systemctl start docker
              systemctl enable docker
              # Add the current user (ubuntu) to the docker group
              usermod -aG docker ubuntu
              # Pull the Nginx Docker image
              docker pull nginx:latest
              # Run the Nginx container
              docker run -d -p 3000:80 --name my-nginx-app nginx:latest
              EOF

  tags = {
    Name = "MyUbuntuDockerAppInstance"
  }
}

resource "aws_security_group" "sg" {
  name        = "my-sg"
  description = "Allow inbound HTTP traffic"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic to anywhere
  }
}

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_public_dns" {
  value = aws_instance.my_instance.public_dns
}
