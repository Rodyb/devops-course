# main_old.tf
provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "boto3-test"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
