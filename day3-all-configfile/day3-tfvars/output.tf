output "ip" {
value = aws_instance.VM1.public_ip
}

output "private_ip" {
 value = aws_instance.VM1.private_ip
}

output "instance_type" {
    value = aws_instance.VM1.instance_type
  
}