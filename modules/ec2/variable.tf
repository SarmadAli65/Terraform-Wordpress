##### EC2 congiurations & networking
locals {
  ami = "ami-02b64aa047cb5edf5"
  instance_type = "t3.micro"
}

##### From VPC module
variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}

##### RDS configurations
variable "rds_endpoint_ec2" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
  sensitive = true
}

variable "admin_email"{
  type = string
}

###### ALB SG
variable "alb_sg" {
  type = string
}