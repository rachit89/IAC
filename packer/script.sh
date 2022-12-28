#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove --purge
sudo apt autoclean
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo useradd -m app -s /bin/bash
sudo passwd -d app
echo 'app ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
sudo mkdir /app
sudo chown app:app /app
sudo apt install wget nodejs collectd net-tools awscli -y
sudo npm install -g npm@latest
sudo npm install -g pm2@latest

#installing codedeploy

sudo apt update
sudo apt install ruby-full -y
sudo wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
cd /home/ubuntu
sudo chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent



#installing cloudwatch-agent

sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip -O AmazonCloudWatchAgent.zip
sudo apt install -y unzip
sudo unzip -o AmazonCloudWatchAgent.zip
sudo ./install.sh
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:AmazonCloudWatch-rachit
sudo systemctl start amazon-cloudwatch-agent.service
sudo systemctl enable amazon-cloudwatch-agent.service
sudo systemctl status amazon-cloudwatch-agent.service
