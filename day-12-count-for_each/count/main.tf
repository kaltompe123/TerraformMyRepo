# #Example-1 
# resource "aws_instance" "name" {
#     ami = "ami-00ca32bbc84273381"
#     instance_type = "t3.micro"  
#     count = 3
    
#     tags = {
#       Name = "dev-${count.index}"
#     }

# }


############################### Example-2 Different names #############
variable "env" {
  type = list(string)
  default =  ["dev","prod" ]
  }

  resource "aws_instance" "name" {
    ami = "ami-00ca32bbc84273381"
    instance_type = "t3.micro"  
    count = length(var.env)
    tags = {
      Name = var.env[count.index]
    }
  }

################################################################################
# #example-3 creating IAM users 
# # variable "user_names" {
# #   description = "IAM usernames"
# #   type        = list(string)
# #   default     = ["user1", "user2", "user3"]
# # }
# # resource "aws_iam_user" "example" {
# #   count = length(var.user_names)
# #   name  = var.user_names[count.index]
# # }