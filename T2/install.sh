#!/bin/bash

sudo mkdir -p /home/ec2-user/backup
sudo echo "0 2 * * * ec2-user /home/ec2-user/backup.sh" >> /etc/crontab

cat <<EOF >> /home/ec2-user/backup.sh
#!/bin/bash
DIRECTORY_TO_BACKUP="/home/ec2-user/backup"
BACKUP_DIR="/home/ec2-user"
S3_BUCKET="my-backup-bucket"
TIMESTAMP="\$(date '+%Y-%m-%d_%H-%M-%S')"
BACKUP_FILENAME="backup_\$TIMESTAMP.tar.gz"          
tar -czf \$BACKUP_DIR/\$BACKUP_FILENAME -C \$DIRECTORY_TO_BACKUP .
aws s3 cp \$BACKUP_DIR/\$BACKUP_FILENAME s3://\$S3_BUCKET/
rm \$BACKUP_DIR/\$BACKUP_FILENAME
EOF

sudo chown -R ec2-user:ec2-user /home/ec2-user/backup*
sudo chmod +x /home/ec2-user/backup.sh
