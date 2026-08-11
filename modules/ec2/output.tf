output "wordpress_instance_1_id" {
    ### The first instances ID
    value = aws_instance.Wordpress-instance-1.id
}

output "wordpress_instance_2_id" {
    ### The second instances ID
    value = aws_instance.Wordpress-instance-2.id
}

output "ec2_sg" {
    value = aws_security_group.allow_alb_traffic.id
}