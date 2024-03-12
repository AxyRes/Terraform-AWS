variable "environment_name" {
  default = "dev"
}

variable "instance_type" {
  default = "t3.xlarge"
}

variable "instance_name" {
  default = "MISR_DEV_EC2"
}

variable "instance_key" {
  default = "MISR"
}

variable "ami" {
  default = "ami-0d889f77081190db1"
}

variable "myip" {
  default = "115.73.164.250/32"
}

variable "jenkinsip" {
  default = "171.246.242.204/32"
}

variable "vpc_cidr_block" {
  default = "10.50.0.0/16"
}

variable "first_public_subnet_cidr" {
  default = "10.50.20.0/24"
}
