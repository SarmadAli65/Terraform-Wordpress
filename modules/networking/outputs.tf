output "vpc_id" {
    description = "The output of the vpc"
    value = aws_vpc.terraform-vpc.id
}

output "public_subnet_1_id" {
    description = "The output of the first public subnet id"
    value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2_id" {
    description = "The output of the second public subnet id"
    value = aws_subnet.public-subnet-2.id
}

output "private_subnet_1_id" {
    description = "The output of the first private subnet id"
    value = aws_subnet.private-subnet-1.id
}

output "private_subnet_2_id" {
    description = "The output of the second private subnet id"
    value = aws_subnet.private-subnet-2.id
}