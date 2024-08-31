resource "aws_instance" "backend" {
  ami                    = "ami-075d39ebbca89ed50" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = file("scripts/backend_user_data.sh")
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  tags = {
    Name = "lti-project-backend"
  }
}

resource "aws_instance" "frontend" {
  ami                    = "ami-075d39ebbca89ed50" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  user_data              = file("scripts/frontend_user_data.sh")
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  tags = {
    Name = "lti-project-frontend"
  }
}