#!/bin/bash
yum update -y
yum install -y docker

# Iniciar el servicio de Docker
service docker start

# Descargar y descomprimir el archivo frontend.zip desde S3
aws s3 cp s3://lti-project-code-bucket-lgp/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Construir la imagen Docker para el frontend
cd /home/ec2-user/frontend
docker build -t lti-frontend .

# Ejecutar el contenedor Docker
docker run -d -p 3000:3000 lti-frontend

# Instalar el agente de Datadog
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.eu" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Timestamp to force update
echo "Timestamp: ${timestamp}"
