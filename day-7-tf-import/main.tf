resource "aws_instance" "dev" {
   ami = "ami-025fe52e1f2dc5044"
   instance_type = "t2.nano"
   key_name = "public"
   tags = {
     Name= "manual_ec2"
   }
  
}