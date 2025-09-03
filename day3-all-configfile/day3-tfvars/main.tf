resource "aws_instance" "VM1" {
  instance_type = var.instance_type
  ami = var.ami_id
}