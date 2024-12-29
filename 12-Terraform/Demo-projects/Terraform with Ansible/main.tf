provider "aws" {
  region = "eu-central-1"  # Change to your preferred region
}

# Fetch the default VPC ID
data "aws_vpc" "default" {
  default = true
}

# Create a security group that allows inbound SSH traffic
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "example" {
  ami           = "ami-08188dffd130a1ac2"
  instance_type = "t2.micro"
  key_name      = "docker-server"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "Terraform-Ansible-Instance"
  }
}

# Wait until the instance is in a running state
resource "null_resource" "wait_for_instance" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.example.public_ip
      user        = "ec2-user"
      private_key = file("/Users/rodybothe/.ssh/docker-server.pem")
      timeout     = "5m"
    }

    inline = [
      "echo Instance is up and running"
    ]
  }

  depends_on = [aws_instance.example]
}

# Run the Ansible playbook
resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = <<EOT
      echo '[web]' > hosts
      echo '${aws_instance.example.public_ip} ansible_ssh_user=ec2-user ansible_ssh_private_key_file=/Users/rodybothe/.ssh/docker-server.pem' >> hosts
      ansible-playbook -i hosts playbook.yml --ssh-common-args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
    EOT
    working_dir = "${path.module}"
  }

  depends_on = [null_resource.wait_for_instance]
}

output "instance_ip" {
  value = aws_instance.example.public_ip
}
