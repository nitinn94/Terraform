# variables.tf

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"  # Default value (if not provided)
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0e2c8caa4b6378d8c"  # AMI ID (us-east-1 region)
}

variable "key_name" {
  description = "The SSH key name to access the EC2 instance"
  type        = string
  default     = "nitin"  # Replace with your actual key name
}
