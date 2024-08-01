#create VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="vpcdev"
  }
}
#create IG anad attach to VPC
resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "cust_ig"
  }
}

#create subnets
resource "aws_subnet" "dev" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.dev.id
  
}
#create Route table and edit routings
resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
}

#Associate subnets for routes 
resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.dev.id
}
# create Security group
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

# launch Ec2 instance in custom nw
resource "aws_instance" "dev" {
  ami = "ami-01376101673c89611"
  instance_type = "t2.micro"
  key_name = "public"
  subnet_id = aws_subnet.dev.id
  vpc_security_group_ids = [aws_security_group.dev.id]
  tags = {
    Name = "cust_ec2"
  }
  
}