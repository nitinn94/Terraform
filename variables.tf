variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"  # Default AWS region
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (US-West-2), update as necessary
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"  # You can change this to any EC2 type, e.g., `t2.small`
}

variable "key_name" {
  description = "The SSH key pair to access the EC2 instance"
  type        = string
}

variable "docker_image" {
  description = "The Docker image to run on the EC2 instance"
  type        = string
  default     = "nginx:latest"  # Replace with your custom Docker image if needed
}

variable "docker_port" {
  description = "The port on which the Docker container will listen"
  type        = number
  default     = 80
}

variable "docker_container_name" {
  description = "The name of the Docker container"
  type        = string
  default     = "my-app-container"
}
