variable "allowed_ports" {
  type = map(string)

  default = {
    "22"   = "0.0.0.0/0"
    "443"  = "203.0.0.0/24"
    "80"   = "192.168.1.0/24"
    "8080" = "10.0.1.0/24"
  }
}


resource "aws_security_group" "New_dyanmic_SG" {
  name        = "new_dyanmic_sg"
  description = "new SG"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {

      description      = "Allows_ports_mysg_group for port ${ingress.key}"
      from_port        = ingress.key
      to_port          = ingress.key
      protocol         = "tcp"
      cidr_blocks      = [ingress.value]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }


  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "dynamic_SG"
  }

}


