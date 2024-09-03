#!/bin/bash
yum update -y
yum install -y docker

# Install Datadog Agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Start Docker service
service docker start

# Download and unzip frontend code
aws s3 cp s3://lti-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/frontend
docker build -t lti-frontend .
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
