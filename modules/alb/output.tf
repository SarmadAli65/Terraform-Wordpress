output "alb_sg_id" {
    value = aws_security_group.alb_sg.id
}

output "alb_domain_name" {
    value = aws_lb.Wordpress_alb.dns_name
}