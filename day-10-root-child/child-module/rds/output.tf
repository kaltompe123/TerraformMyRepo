output "rds_db_name" {
  value = aws_db_instance.default.db_name
}

output "db_username" {
  value = aws_db_instance.default.username
}

output "db_pass" {
value = aws_db_instance.default.password
}

output "db_subnet_group_id" {
  value = aws_db_subnet_group.db_subnet_group.subnet_ids
}