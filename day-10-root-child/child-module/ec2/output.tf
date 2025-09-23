output "ec2_instance_id" {
    value = aws_instance.name.id
}

output "ec2_instance_type" {
  value = aws_instance.name.instance_type
}

output "ec2_public-ip" {
  value = aws_instance.name.public_ip
}

output "ec2_private-ip" {
  value = aws_instance.name.private_ip
}

output "ec2_subnet_id" {
  value = aws_instance.name.subnet_id
}