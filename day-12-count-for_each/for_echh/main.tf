
variable "env" {
  type = list(string)
  default = ["dev" , "prod"]
}



  resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t3.micro"  
  
  for_each = toset(var.env)
    #count =length(var.env)   if it is count 
    tags = {
      Name = each.value
    }
  
  }



# variable "environment" {
#   type = list(string)
#   default = [ "one" , "two", "three"]
  
# }

# resource "aws_instance" "name1" {
#   ami = "ami-00ca32bbc84273381"
#   instance_type = "t3.micro"

#   for_each = toset(var.environment)
#   tags = {
#     Name = each.value
#   }
  
# }