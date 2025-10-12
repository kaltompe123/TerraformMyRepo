provider "aws" {

}

resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("D:/GIT_teraform/TerraformMyRepo/day-13-provisoners/id_rsa.pub")


}




resource "aws_vpc" "MyVPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.MyVPC.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "publicpub1"
  }
}

resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.MyVPC.id

}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

resource "aws_route_table_association" "rt1" {
  route_table_id = aws_route_table.RT.id
  subnet_id      = aws_subnet.sub1.id
}



resource "aws_security_group" "MySG" {
  name   = "cust_sg"
  vpc_id = aws_vpc.MyVPC.id

  ingress = [
    for port in [22, 80, 443, 3306] : {
      description      = "allow ${port} in SG group"
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
    description = "allow SG group"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

}


resource "aws_instance" "server" {
  ami                         = "ami-00ca32bbc84273381"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sub1.id
  key_name                    = aws_key_pair.example.key_name
  vpc_security_group_ids      = [aws_security_group.MySG.id]
  associate_public_ip_address = true

  tags = {
    Name = "testserver"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("D:/GIT_teraform/TerraformMyRepo/day-13-provisoners/id_rsa")
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "file10"
    destination = "/home/ec2-user/file10"
  }

  # provisioner "local-exec" {
  #  command =  "echo  'file_local_exec_file' >> abc "
  # }

  # provisioner "remote-exec" {
  #   inline = [ 
  #    "touch /home/ec2-user/file200",
  #    "echo 'hello from remote_exec_testing + terraform addition taint testing+ taint testing' >>/home/ec2-user/file200"
  #    ]

  # }
}


resource "null_resource" "name" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.server.public_ip
      private_key = file("D:/GIT_teraform/TerraformMyRepo/day-13-provisoners/id_rsa")
      timeout     = "2m"

    }

    inline = [ 
      "echo 'hello from remote_exec_testing-null againn' >>/home/ec2-user/file201"
     ]

  }
  
  triggers = {
    always_run = "${timestamp()}"  # Forces rerun every time
  }

}



#Solution-2 to Re-Run the Provisioner
#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server     #terraform taint & untaint
# terraform apply

#terraform taint 
#However — ⚠️ it’s now deprecated and replaced by the terraform apply -replace syntax.