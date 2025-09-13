resource "aws_vpc" "name" {
cidr_block = "10.0.0.0/16"
tags = {
  Name = "dev" 
}
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
  
}

resource "aws_security_group" "rds" {
  name        = "rds-sg"
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db-sub-grp" {
  name = "mycustsub"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

}
data "aws_secretsmanager_secret" "manual_secret" {
name = "myrdsecret" #manual secret name from existing
  
}

data "aws_secretsmanager_secret_version" "manual_secret_version" {
secret_id = data.aws_secretsmanager_secret.manual_secret.id
}

locals {
  rds_credetials = jsondecode(data.aws_secretsmanager_secret_version.manual_secret_version.secret_string)
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             =  local.rds_credetials.username
  password             =  local.rds_credetials.password
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.db-sub-grp.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.rds.id ]
  depends_on = [ aws_db_subnet_group.db-sub-grp ]
}

output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint

}


