provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

module "custom-vpc" {
  source = "./modules/terraform-vpc"
  prefix         = var.environment_name
  separator      = "-"
  name           = "MISR"
  vpc_cidr_block = var.vpc_cidr_block
  first_public_subnet_cidr  = var.first_public_subnet_cidr
}

module "custom_security_group" {
  source     = "./modules/terraform-security-group"
  allowed_ip_jenkins = var.jenkinsip
  allowed_ip_home = var.myip
  vpc_id     = module.custom-vpc.vpc_id
}

#module "custom-alb" {
#  source = "./modules/terraform-loadbalancer"

#  alb_name                = "my-application-lb"
#  internal                = false
#  subnet_ids              = module.custom-vpc.public_subnet_ids
#  security_group_ids      = [module.custom-security-group.security_group_id]
#  enable_deletion_protection = false
#  enable_http2            = true
#}


resource "aws_instance" "artifactory_instance" {
  ami                    = var.ami           # Amazon Linux 2 AMI ID
  instance_type          = var.instance_type # Instance type (small, free tier eligible)
  key_name               = var.instance_key       # Your SSH key pair name (replace with your own)
  subnet_id              = module.custom-vpc.public_subnet_ids
  security_groups        = [module.custom_security_group.security_group_id]
  associate_public_ip_address = true
  root_block_device {
      volume_size = 50
      volume_type = "gp3"
      delete_on_termination = true
  }
  tags = {
    Name = "${var.instance_name}"
  }
}

resource "aws_instance" "agent_linux_instance" {
  ami                    = var.ami           # Amazon Linux 2 AMI ID
  instance_type          = var.instance_type # Instance type (small, free tier eligible)
  key_name               = var.instance_key       # Your SSH key pair name (replace with your own)
  subnet_id              = module.custom-vpc.public_subnet_ids
  security_groups        = [module.custom_security_group.security_group_id]
  associate_public_ip_address = true

  root_block_device {
      volume_size = 50
      volume_type = "gp3"
      delete_on_termination = true
  }

  tags = {
    Name = "${var.instance_name}"
  }
}

#resource "aws_lb_listener" "load_balancer" {
#  load_balancer_arn = module.my_alb.alb_arn
#  port             = 80
#  protocol         = "HTTP"
#  default_action {
#    type             = "fixed-response"
#    fixed_response {
#      content_type = "text/plain"
#      status_code  = "200"
#    }
#  }
#}