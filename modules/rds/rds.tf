###### RDS Subnets
resource "aws_db_subnet_group" "db_subnet_groups" {
    name = "subnet_groups"
    subnet_ids = var.subnets_id

    tags = {
      Name = "db_subnet_groups"
    }
}

###### RDS Security Groups
resource "aws_security_group" "db_security_group" {
    vpc_id = var.vpc_id
    tags = {
      Name = "rds_security_group"
    }
}

###### RDS DB instance config
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "alisrmad"
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_groups.name
  vpc_security_group_ids = [ aws_security_group.db_security_group.id ]
  skip_final_snapshot  = true
  multi_az = true

  tags = {
    Name = "My_RDS_DB"
  }
}