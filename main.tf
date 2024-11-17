# Configure the backend for storing the state file in S3
terraform {
  backend "s3" {
    bucket = "my-trapti-bucket"
    key    = "terraform/state/terraform.tfstate"
    region = "us-east-1"
  }
}

# Define the provider
provider "aws" {
  region = "us-east-1" # Specify your AWS region
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh1" {
  name        = "allow_ssh1"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (use cautiously)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "example1" {
  ami           = "ami-0866a3c8686eaeeba" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"              # Instance type
  key_name      = "jenkins-server"
  security_groups = [aws_security_group.allow_ssh1.name] # Attach security group

  tags = {
    Name = "My-Automation"
  }
}
