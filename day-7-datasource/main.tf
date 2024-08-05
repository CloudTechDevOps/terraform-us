provider "aws" {
  
}
data "aws_subnet" "dev" {
  filter {
    name   = "tag:Name"
    values = ["Subnet_1"]
  }
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

resource "aws_instance" "name" {
    ami = data.aws_ami.amzlinux.id
    instance_type = "t2.micro"
    key_name = "public"
    #subnet_id = "subnet-9a6045d6"
    subnet_id = data.aws_subnet.dev.id


    tags = {
        Name = "day-11"
    }
}