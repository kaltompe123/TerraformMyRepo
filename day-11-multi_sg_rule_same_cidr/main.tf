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

