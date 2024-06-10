## Terraform Exercise

This exercise uses Terraform to create an AWS EC2 instance with the following specifications:

- Region: eu-west-2
- Type: t2.micro
- AMI: Amazon Linux 2 x64
- With public IP address.
- Allowing SSH access from anywhere (0.0.0.0/0)
- With a private S3 bucket called: my-backup-bucket
- With a script that creates a backup of the /home/ec2-user/backup directory every day at 2:00 am UTC and copies it to the “my-backup-bucket” bucket. The format of the backup file will be a tgz file with a timestamp as its name. 

### Note

I have omitted this part: *Output the URL of the uploaded backup file.* It does not make sense to me because the backup has not yet been created and you do not know its timestamp.
