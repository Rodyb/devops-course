provider "aws" {
  region     = "eu-central-1"
  access_key = ""
  secret_key = ""
}

variable vpc_cidr_block {}
variable subnet_cidr_block {}
variable avail_zone {}
variable env {}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = var.cidr_blocks[1].name
  }
}
