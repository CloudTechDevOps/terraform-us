variable "test" {
    type = list(string)
    default = [ "dev","prod"]
  
}
resource "aws_instance" "dev" {
  ami = "ami-01376101673c89611"
  instance_type = "t2.micro"
  key_name = "public"
  for_each = toset(var.test)
   tags = {
     Name = each.value #instance will be created by calling the tags from variabels 
   }
}