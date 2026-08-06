##### ALB Security group
resource "aws_security_group" "alb_sg" {
    name = "allow all traffic"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "http"
    from_port = 80
    to_port = 80
}

##### Target group
resource "aws_lb_target_group" "alb_target_group_wordpress" {
    name = "tf_wordpress_tg"
    target_type = "alb"
    port = 80
    protocol = "TCP"
    vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "alb_target_group_instance_attachments" {
    target_group_arn = aws_lb_target_group.alb_target_group_wordpress.arn
    for_each = {
      for x, y in var.instance_ids:
      x => y 
    }
    target_id = each.value
}



resource "aws_lb" "Wordpress_alb" {
    name = "terraform_alb"
    internal = false
    load_balancer_type = "application"
    security_groups = aws_security_group.alb_sg.id
    subnets = [ var.alb_subnet_1, var.alb_subnet_2 ]
    
    tags = {
      auto-delet = "no"
    }
  
}