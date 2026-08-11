####### VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name        = "wordpress-vpc"
    auto-delete = "no"
  }
}

####### IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "terraform-IGW"
  }

}

###### Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.availability_zone-1a
  tags = {
    Name        = "wordpress-pubsub-1"
    auto-delete = "no"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone-1b
  tags = {
    Name        = "wordpress-pubsub-2"
    auto-delete = "no"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone-1a
  tags = {
    Name        = "wordpress-privsub-1"
    auto-delete = "no"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone-1b
  tags = {
    Name        = "wordpress-privsub-2"
    auto-delete = "no"
  }
}

####### Elastic IP
resource "aws_eip" "eip" {
  network_border_group = "us-east-1"
}


####### Nat Gateway
resource "aws_nat_gateway" "terraform-ngw" {
  vpc_id            = aws_vpc.terraform-vpc.id
  availability_mode = "regional"
  tags = {
    Name = "terraform-ngw"
  }
}

#resource "aws_nat_gateway_eip_association" "eip_association" {
#  allocation_id = aws_eip.eip.id
#  nat_gateway_id = aws_nat_gateway.terraform-ngw.id  
#}


###### Route tables
resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terraform-ngw.id
  }

  tags = {
    Name        = "private_routetable"
    auto-delete = "no"
  }
}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "public_routetable"
    auto-delete = "no"
  }
}


###### RouteTable association
resource "aws_route_table_association" "rt_public_association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "rt_public_association_2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "rt_private_assocation" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_route_table_association" "rt_private_assocation_2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.rt-private.id
}




