##### EC2 Security groups
resource "aws_security_group" "allow_alb_traffic" {
  name = "allow_alb_traffic"
  description = "Allow all traffic from the ALBs"
  vpc_id = var.vpc_id
  tags = {
    Name = "allow_alb_traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb_ingress_http" {
  security_group_id = aws_security_group.allow_alb_traffic.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80  
  referenced_security_group_id = var.alb_sg_id
}

resource "aws_vpc_security_group_egress_rule" "allow_alb_egress" {
  security_group_id = aws_security_group.allow_alb_traffic.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}



###### EC2 instance configurations
resource "aws_instance" "Wordpress-instance-1" {
    ami = local.ami
    instance_type = local.instance_type
    subnet_id = var.private_subnet_1_id
    associate_public_ip_address = false
    security_groups = [ aws_security_group.allow_alb_traffic.id ]
    user_data = templatefile("${path.module}/cloud-init.yaml",{
        rds_user = "alisrmad"
        rds_pass = var.db_password
        rds_endpoint = var.rds_endpoint_ec2
        admin_username = var.admin_username
        admin_password = var.admin_password
        admin_emailaddress = var.admin_email
    })
    tags = {
      Name = "wordpress_instance_1"
      auto-delete = "no"
    }
    #### Need to do Security group to accept ALB
}

resource "aws_instance" "Wordpress-instance-2" {
    ami = local.ami
    instance_type = local.instance_type
    subnet_id = var.private_subnet_2_id
    associate_public_ip_address = false
    security_groups = [ aws_security_group.allow_alb_traffic.id ]
    user_data = templatefile("${path.module}/cloud-init.yaml",{
        rds_user = "alisrmad"
        rds_pass = var.db_password
        rds_endpoint = var.rds_endpoint_ec2
        admin_username = var.admin_username
        admin_password = var.admin_password
        admin_emailaddress = var.admin_email
    })
    tags = {
      Name = "wordpress_instance_2"
      auto-delete = "no"
    }
    #### Need to do Security group to accept ALB
}
