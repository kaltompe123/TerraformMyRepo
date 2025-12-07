variable "frontend-asg-tag" {}
variable "backend-asg-tag" {}
variable "prvt3_subid" {}
variable "prvt4_subid" {}
variable "prvt5_subid" {}
variable "prvt6_subid" {}

variable "aws_lb_target_group_front_end_arn" {}
variable "aws_launch_template_frontend_id" {}  
variable "aws_launch_template_frontend_latest_version" {}



variable "aws_lb_target_group_back_end_arn" {}
variable "aws_launch_template_backend_id" {}
variable "aws_launch_template_backend_latest_version" {}