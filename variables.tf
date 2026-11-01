variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_subnets" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "instance_type" {
  default = "t3.micro"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "min_size"{
type    = number
default = "2"
}

variable "max_size"{
type    = number
default = "4"
}

variable "desired_capacity" {
type    = number
default = "2"
}

variable "db_name" {
default = "appdb"
}

variable "username" {
default= "appadmin"
}

