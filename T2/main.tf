provider "aws" {
  region = "eu-west-2"
}


# Bucket
resource "aws_s3_bucket" "backup-bucket" {
  bucket = "my-backup-bucket"

  tags = {
    Name = "my-backup-bucket"
  }
}


# Instance
resource "aws_instance" "backup-instance" {
  ami           = "ami-01980876755d1e5ac"
  instance_type = "t2.micro"
  user_data = "${file("install.sh")}"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ssh.id]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.id}"

  tags = {
    Name = "backup-instance"
  }
}
