output "vpc_id" {
  value = aws_vpc.three-tier.id
}

output "vpc_name" {
  value = aws_vpc.three-tier.tags
}

output "pub1-subid" {
  value = aws_subnet.pub1.id
}

output "pub2-subid" {
  value = aws_subnet.pub2.id
}

output "prvt3_subid" {
  value = aws_subnet.prvt3.id
}
output "prvt4_subid" {
  value = aws_subnet.prvt4.id
}

output "prvt5-subid" {
  value = aws_subnet.prvt5.id
}
output "prvt6-subid" {
  value = aws_subnet.prvt6.id
}

output "prvt7-subid" {
  value = aws_subnet.prvt7.id
}
output "prvt8-subid" {
  value = aws_subnet.prvt8.id 
}