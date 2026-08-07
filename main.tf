terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source = "./modules/ec2"
  ### EC2 networking
  vpc_id = module.networking.vpc_id
  private_subnet_1_id = module.networking.private_subnet_1_id
  private_subnet_2_id = module.networking.private_subnet_2_id

  ### wordpress admin
  admin_password = var.admin_password_wordpress
  admin_username = var.admin_username_wordpress
  admin_email = var.admin_email_wordpress

  ### RDS
  db_password = module.rds.db_instance_pass
  rds_endpoint_ec2 = module.rds.db_instance_endpoint

  ### ALB
  alb_sg_id = module.alb.alb_sg_id


}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.networking.vpc_id
  subnets_id = [ module.networking.private_subnet_1_id, module.networking.private_subnet_2_id ]
  password = var.dv_password
}

module "alb" {
  source = "./modules/alb"

  ### ALB networking
  vpc_id = module.networking.vpc_id
  alb_subnet_1 = module.networking.public_subnet_1_id
  alb_subnet_2 = module.networking.public_subnet_2_id

  ### EC2
  instance_ids = [ module.ec2.wordpress_instance_1_id, module.ec2.wordpress_instance_2_id ]
}