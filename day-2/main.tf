# Create VPC and attache to IG
resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name="cust_vpc"
    }
}

# Create IG and attach to VPC
resource "aws_internet_gateway" "dev" {

    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "cust_ig"
    } 
  
}

# Create public subnet
resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "cust_subnet_pub"
    } 
}

# Create Route table 
resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.dev.id
    tags = {
      Name = "cust_pub_rt"
    } 

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev.id
    }
    
}
resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.dev.id
  
}
resource "aws_security_group" "dev" {
    vpc_id = aws_vpc.dev.id
    name        = "allow_traffic"
    description = "Allow TLS inbound traffic and all outbound traffic"
    tags = {
      Name = "cust_dev_sg"
    }
   ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

resource "aws_instance" "dev" {
    ami="ami-01376101673c89611"
    instance_type = "t2.micro"
    key_name = "public"
    vpc_security_group_ids = [aws_security_group.dev.id]
    associate_public_ip_address = true
    subnet_id = aws_subnet.dev.id
    availability_zone = "ap-south-1b"
    tags = {
      Name = "dev-ec8"
    }
}
