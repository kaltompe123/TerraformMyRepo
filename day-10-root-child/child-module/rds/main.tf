resource "aws_db_subnet_group" "db_subnet_group" {
    name = "db_subnet_group"
  subnet_ids = [var.db_subnetid_1a, var.db_subnetid_1b  ]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_pass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  #publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name 
  depends_on = [ aws_db_subnet_group.db_subnet_group ]
}

