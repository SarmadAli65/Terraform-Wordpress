resource "aws_instance" "Wordpress-instance-1" {
    ami = local.ami
    instance_type = local.instance_type
  
}