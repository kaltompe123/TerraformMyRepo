provider "aws" {
  
}

resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t3.micro"  
    tags = {
      Name = "dev"
    }

  
lifecycle {
  ignore_changes = [ tags, ]
  #create_before_destroy = true 
  #prevent_destroy = true 
}



}
