variable "test" {
    type = list(string)
    default = [ "dev", "prod"]
  
}
resource "aws_instance" "dev" {
  ami = "ami-01376101673c89611"
  instance_type = "t2.micro"
  key_name = "public"
  count = length(var.test)
#   tags = {
#     Name = "web-${count.index}" #instance will be created web-0, web-1
#   }
   tags = {
     Name = var.test[count.index] #instance will be created by calling the tags from variabels 
   }
}