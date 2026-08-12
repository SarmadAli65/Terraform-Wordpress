# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
  backend "s3" {
    bucket = "terraform-wordpress-sarmad"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region
}

provider "cloudflare" {
}




module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source = "./modules/ec2"
  ### EC2 networking
  vpc_id              = module.networking.vpc_id
  private_subnet_1_id = module.networking.private_subnet_1_id
  private_subnet_2_id = module.networking.private_subnet_2_id

  ### wordpress admin
  admin_password = var.admin_password_wordpress
  admin_username = var.admin_username_wordpress
  admin_email    = var.admin_email_wordpress

  ### RDS
  db_password      = module.rds.db_instance_pass
  rds_endpoint_ec2 = module.rds.db_instance_endpoint

  ### ALB
  alb_sg_id = module.alb.alb_sg_id


}

resource "aws_vpc_security_group_ingress_rule" "ec2_to_rds" {
  security_group_id            = module.rds.db_sg
  referenced_security_group_id = module.ec2.ec2_sg
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306

}


module "rds" {
  source     = "./modules/rds"
  vpc_id     = module.networking.vpc_id
  subnets_id = [module.networking.private_subnet_1_id, module.networking.private_subnet_2_id]
  password   = var.dv_password
}

module "alb" {
  source = "./modules/alb"

  ### ALB networking
  vpc_id       = module.networking.vpc_id
  alb_subnet_1 = module.networking.public_subnet_1_id
  alb_subnet_2 = module.networking.public_subnet_2_id

  ### EC2
  instance_ids = [module.ec2.wordpress_instance_1_id, module.ec2.wordpress_instance_2_id]

  ### ACM cert ARN
  certificate_arn = module.acm.cert_arn
}

module "acm" {
  source = "./modules/acm"
}

### Imports

import {
  to = module.acm.aws_acm_certificate.certification
  id = var.import_cert_arn
}

module "cloudflare" {
  source      = "./modules/cloudflare"
  domain_name = module.alb.alb_domain_name
}

