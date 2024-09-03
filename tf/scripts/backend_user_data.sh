#!/bin/bash
yum update -y
yum install -y docker

# Iniciar el servicio de Docker
service docker start

# Descargar y descomprimir el archivo backend.zip desde S3
aws s3 cp s3://lti-project-code-bucket-lgp/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Construir la imagen Docker para el backend
cd /home/ec2-user/backend
docker build -t lti-backend .

# Ejecutar el contenedor Docker
docker run -d -p 8080:8080 lti-backend

# Instalar el agente de Datadog
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${datadog_api_key} DD_SITE="datadoghq.eu" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Timestamp to force update
echo "Timestamp: ${timestamp}"
