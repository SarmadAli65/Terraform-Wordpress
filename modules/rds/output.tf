output "db_instance_id" {
    description = "the db instances ID"
    value = aws_db_instance.default.id 
}

output "db_instance_endpoint" {
    description = "address of the rds database for "
    value = aws_db_instance.default.endpoint
}

output "db_instance_pass" {
    description = "Password of the DB"
    value = aws_db_instance.default.password
    sensitive = true
}

output "db_subnet_groups" {
    description = "the subnet groups of the db instances"
    value = aws_db_subnet_group.db_subnet_groups.arn
  
}
