output "aws_lb_target_group_back_end_arn"{
  value = aws_lb_target_group.back_end.arn
}

output "aws_lb_target_group_front_end_arn" {
  value = aws_lb_target_group.front_end.arn
}