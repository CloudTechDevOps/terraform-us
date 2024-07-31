output "ec2_public_ip" {
    value = aws_instance.dev.public_ip
    description = "print the value of public ip"
  
}

output "private_ip" {
    value = aws_instance.dev.private_ip
    description = "print the value of private ip"
    sensitive = true
   
}