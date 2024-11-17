terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}


provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
