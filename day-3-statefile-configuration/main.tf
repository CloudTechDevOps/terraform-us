resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key
    tags = {
        Name = "windows-ec2"
    }
}

resource "aws_s3_bucket" "name" {
    bucket = "usdvushvcsihvc"

}
