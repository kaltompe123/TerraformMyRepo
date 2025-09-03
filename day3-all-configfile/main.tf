resource "aws_instance" "name" {
     ami = var.ami_id
     instance_type = var.instance_type

     #instance_type = "t3.nano"   #hardcoded 

    tags = {
        name = "day3"
        }
}  

