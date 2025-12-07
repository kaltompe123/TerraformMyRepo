#bastion server 

resource "aws_instance" "back" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.pub1-subid
  vpc_security_group_ids = [var.bastion_hostsg_id]
  
  tags = {
    Name = "bastion-server"
  }
}
