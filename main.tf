# main.tf

provider "aws" {
  region = "us-west-2"  # Choose your AWS region
}

resource "aws_instance" "my_instance" {
  ami             = var.ami_id          # Use the variable for AMI ID
  instance_type   = var.instance_type   # Use the variable for Instance Type
  key_name        = var.key_name        # Use the variable for SSH Key Pair
  security_groups = [aws_security_group.sg.name]
  
  # User data to install Docker and deploy application
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              systemctl enable docker
              docker pull nginx:latest
              docker run -d -p 80:80 --name my-app nginx:latest
              EOF

  tags = {
    Name = "MyDockerAppInstance"
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
