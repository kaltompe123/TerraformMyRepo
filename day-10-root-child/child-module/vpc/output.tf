output "vpc_name" {
  value = aws_vpc.name.tags

}

output "vpc_id" {
  value = aws_vpc.name.id
}

 output "vpc_cidr" {
   value = aws_vpc.name.cidr_block
 }

output "subnet-1a_id" {
  value = aws_subnet.subnet_1a.id 
}

output "subnet-1b_id" {
  value = aws_subnet.subnet_1b.id
}