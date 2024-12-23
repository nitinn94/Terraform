# variables.tf

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"  # Default value (if not provided)
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (us-west-2 region)
}

variable "key_name" {
  description = "The SSH key name to access the EC2 instance"
  type        = string
  default     = "my-key-pair"  # Replace with your actual key name
}
