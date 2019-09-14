#!/bin/bash

curl -w "\n" http://169.254.169.254/latest/meta-data/hostname > /home/ec2-user/scripts/metadata.txt 
curl -w "\n" http://169.254.169.254/latest/meta-data/iam/info >> /home/ec2-user/scripts/metadata.txt 
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups >> /home/ec2-user/scripts/metadata.txt
