#!/bin/bash
sudo apt upgrade -y
sudo mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo apt install amazon-ssm-agent.deb -y
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
rm amazon-ssm-agent.deb
