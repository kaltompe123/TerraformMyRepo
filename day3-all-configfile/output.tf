output "ip" {
  value = aws_instance.name.public_ip
}

output "pvtip" {
value = aws_instance.name.private_ip
}