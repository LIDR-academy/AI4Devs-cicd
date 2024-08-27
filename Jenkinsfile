pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        S3_BUCKET = 'lti-project-code-bucket'
        PROJECT_NAME = 'lti-project'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install AWS CLI') {
            steps {
                sh '''
                    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                    unzip -o awscliv2.zip
                    sudo ./aws/install --update
                '''
            }
        }

        stage('Zip Projects') {
            steps {
                sh '''
                    zip -r backend.zip backend/
                    zip -r frontend.zip frontend/
                '''
            }
        }

        stage('Upload Code to S3') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                        aws s3 cp backend.zip s3://${S3_BUCKET}/backend.zip --region ${AWS_REGION}
                        aws s3 cp frontend.zip s3://${S3_BUCKET}/frontend.zip --region ${AWS_REGION}
                    '''
                }
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                    curl -LO https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
                    rm -rf terraform
                    unzip terraform_1.5.7_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir('tf') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('tf') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('tf') {
                    sh 'terraform apply'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}