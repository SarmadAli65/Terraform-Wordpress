##### ALB Security group
resource "aws_security_group" "alb_sg" {
    name = "allow-all-traffic"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_egress_ipv4" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
  
}

##### Target group
resource "aws_lb_target_group" "alb_target_group_wordpress" {
    name = "tf-wordpress-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "alb_target_group_instance_attachments" {
    for_each = {
      for x, y in var.instance_ids:
      x => y 
    }
    target_group_arn = aws_lb_target_group.alb_target_group_wordpress.arn
    target_id = each.value
}



resource "aws_lb" "Wordpress_alb" {
    name = "terraform-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = [ var.alb_subnet_1, var.alb_subnet_2 ]
    
    tags = {
      auto-delet = "no"
    }
}

resource "aws_lb_listener" "wordpress_listener" {
    load_balancer_arn = aws_lb.Wordpress_alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.alb_target_group_wordpress.arn
    }
}