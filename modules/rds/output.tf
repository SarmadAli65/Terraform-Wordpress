output "db_instance_id" {
    description = "the db instances ID"
    value = aws_db_instance.default.id 
}

output "db_instance_endpoint" {
    description = "address of the rds database for "
    value = aws_db_instance.default.address
  
}
