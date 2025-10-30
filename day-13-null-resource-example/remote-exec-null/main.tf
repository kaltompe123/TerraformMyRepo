# Create the RDS instance
resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-mysql-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Password123!"
  db_name                 = "dev"
  allocated_storage       = 20
  skip_final_snapshot     = true
  publicly_accessible     = true
  
  
}


# Example EC2 instance (replace with yours if already existing)
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("D:/GIT_teraform/TerraformMyRepo/day-13-provisoners/id_rsa.pub")


}



resource "aws_instance" "sql_runner" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.example.key_name # Replace with your key pair name
  associate_public_ip_address = true
  user_data = file("test.sh")
  depends_on =  [aws_security_group.mysg_group]
  vpc_security_group_ids = [aws_security_group.mysg_group.id]
  tags = {
    Name = "SQL Runner"
  }
}

resource "aws_security_group" "mysg_group" {
  description = "mysg_group"
  name        = "mysg_group"

  ingress = [

    for port in [22, 80, 8080, 443, 3089] : {
      description      = "Allows_ports_mysg_group"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }


  ]

egress {
 protocol = "-1"
 from_port = 0
 to_port = 0
 cidr_blocks = ["0.0.0.0/0"]

}
 tags = {
   Name = "devops-project-Kalyan-SG"
 }

}





# Deploy SQL remotely using null_resource + remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds, aws_instance.sql_runner]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.sql_runner.public_ip
    private_key = file("D:/GIT_teraform/TerraformMyRepo/day-13-provisoners/id_rsa")
    timeout     = "2m"

  }

  provisioner "file" {
    source      = "init.sql"
    destination = "/home/ec2-user/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
      #"mysql -h ${aws_db_instance.mysql_rds.address} -u ${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]} -p${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]} < /tmp/init.sql"
      "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -pPassword123! dev < /home/ec2-user/init.sql"
    ]

  }

  triggers = {
    always_run = timestamp() #trigger every time apply 
  }
}




# ADD RDS creation script only accessbale interanlly  disable public access 
# Remote provisioner server also should create in same vpc 
# enable secrets from secret manager and call secrets into RDS for this process vpc endpoint is require or nat gateway is required to access secrets to rds internall as secremanger is not in side VPC sefrvice 