output "ip" {
value = aws_instance.name.public_ip
}

output "private_ip" {
  value = aws_instance.name.private_ip
}

output "instance_type" {
value = aws_instance.name.instance_type
}

output "ami" {
value = aws_instance.name.ami
}

