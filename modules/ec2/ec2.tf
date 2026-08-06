

resource "aws_instance" "Wordpress-instance-1" {
    ami = local.ami
    instance_type = local.instance_type
    subnet_id = var.private_subnet_1_id
    associate_public_ip_address = false
    user_data = templatefile("${path.module}/ec2.cloud-init.yaml",{
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
    user_data = templatefile("${path.module}/ec2.cloud-init.yaml",{
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
