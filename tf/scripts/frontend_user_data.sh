#!/bin/bash
sudo yum update -y
sudo yum install -y docker

# Iniciar el servicio de Docker
sudo service docker start

# Descargar y descomprimir el archivo frontend.zip desde S3
aws s3 cp s3://ai4devs-project-code-bucket/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Construir la imagen Docker para el frontend
cd /home/ec2-user/frontend
sudo docker build -t lti-frontend .

# Ejecutar el contenedor Docker
sudo docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
