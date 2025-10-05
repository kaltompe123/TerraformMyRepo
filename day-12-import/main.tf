resource "aws_instance" "name" {
   ami = "ami-00ca32bbc84273381"
   instance_type = "t3.micro"

   tags = {
     Name = "prod"
   }

}



#terraform import aws_instance.name i-099d74c66547e88   ##<unique identifiers need to use like instance id ,s3bucket for import "
#run terraform plan & update resource accordingly  until you get "No changes"