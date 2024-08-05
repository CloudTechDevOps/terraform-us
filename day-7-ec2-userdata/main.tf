resource "aws_instance" "dev" {
  ami = "ami-01376101673c89611"
  instance_type = "t2.micro"
  key_name = "public"
  user_data = file("test.sh")
}