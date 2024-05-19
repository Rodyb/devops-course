variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-08188dffd130a1ac2"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair"
  default     = "docker-server" # Replace with your key pair name
}
variable "private_key_path" {
  description = "Path to the private key file"
  default     = "~/.ssh/docker-server.pem"
}

