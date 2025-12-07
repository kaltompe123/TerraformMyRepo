# Autoscaling Group Resource
resource "aws_autoscaling_group" "frontend-asg" {
  name_prefix = "frontend-asg"
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = [var.prvt3_subid, var.prvt4_subid]
  target_group_arns = [var.aws_lb_target_group_front_end_arn]
  
  health_check_type = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds  
  # Launch Template
  launch_template {
    id      = var.aws_launch_template_frontend_id
    version = var.aws_launch_template_frontend_latest_version
  }
  # Instance Refresh
   instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Group's health check grace period.
      min_healthy_percentage = 50
    }
    triggers = [ /*"launch_template",*/ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger
  } 
  tag {
    key                 = "Name"
    value = "var.frontend-asg-tag"
    propagate_at_launch = true
  }      
}

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################

# Autoscaling Group Resource
resource "aws_autoscaling_group" "backend-asg" {
  name_prefix = "backend-asg"
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = [var.prvt5_subid, var.prvt6_subid]
  target_group_arns = [var.aws_lb_target_group_back_end_arn]
  health_check_type = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds  
  # Launch Template
  launch_template {
    id      = var.aws_launch_template_backend_id
    version = var.aws_launch_template_backend_latest_version
  }
  # Instance Refresh
    instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Group's health check grace period.
      min_healthy_percentage = 50
    }
    triggers = [ /*"launch_template",*/ "desired_capacity" ] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger
  } 
 
  tag {
    key                 = "Name"
    #value               = "backend-asg"
    value = "var.backend-asg-tag"
    propagate_at_launch = true
  }      
}