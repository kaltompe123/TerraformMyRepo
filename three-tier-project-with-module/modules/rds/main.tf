resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  identifier = "book-rds"
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.id
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = var.rds-username
  password               = var.rds-password
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.book-rds-sgid]
  depends_on = [ aws_db_subnet_group.sub-grp ]
  publicly_accessible = false
  backup_retention_period = 7

  
  tags = {
    DB_identifier = "book-rds"
  }
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = [ var.prvt7-subid, var.prvt8-subid ]
  depends_on = [ var.prvt7-subid,var.prvt8-subid ]

  tags = {
    Name = "My DB subnet group"
  }

}
