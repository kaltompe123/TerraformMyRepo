output "aws_launch_template_frontend_id" {
value = aws_launch_template.frontend.id
}

output "aws_lb_target_group_front_end_arn" {
 value = aws_launch_template.frontend.arn
}

output "aws_launch_template_frontend_latest_version" {
 value = aws_launch_template.frontend.latest_version
}

output "aws_launch_template_backend_id" {
  value = aws_launch_template.backend.id
}

output "aws_lb_target_group_back_end_arn" {
  value = aws_launch_template.backend.arn 
}

output "aws_launch_template_backend_latest_version" {
  value = aws_launch_template.backend.latest_version
}


