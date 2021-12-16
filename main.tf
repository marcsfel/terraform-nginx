provider "aws" {
    region = var.region
}



terraform {
    backend "s3" {
        bucket = "terraform-marcsfel"
        key = "terraform.tfstate"
        region = "us-west-2"     
    }
}

resource "aws_security_group" "Nginx" {
    name = "Nginx Webserver"
    description = "Security group for Nginx EC2"

    ingress {
        from_port = 80
        protocol = "TCP"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.keyname
  public_key = var.publickey
}

resource "aws_instance" "Nginx_instance" {
    instance_type = var.type_instance
    ami = var.ami_instance
    key_name = var.keyname
    tags = {
      Name = "Nginx"
    }
    security_groups = ["${aws_security_group.Nginx.name}"]
    user_data = <<-EOF
  #!/bin/sh
  sudo apt update
  sudo apt install -y nginx
  sudo systemctl start nginx
  EOF
}