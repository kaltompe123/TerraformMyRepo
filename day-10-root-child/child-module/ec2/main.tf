resource "aws_instance" "name" {
    #ami = "ami-00ca32bbc84273381"
    ami =var.ami_id 
    instance_type = var.instance_type
    availability_zone = var.az
    subnet_id = var.subnet_id_for-ec2

}
   
 
