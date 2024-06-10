provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "backup-instance" {
  ami           = "ami-01980876755d1e5ac"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = "backup-instance"
  }
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

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

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.backup_instance.public_ip
}
