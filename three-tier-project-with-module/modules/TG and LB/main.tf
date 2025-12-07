##for backend TG & LB 
resource "aws_lb_target_group" "back_end" {
  name     = "backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = [ var.vpcname ]

}

resource "aws_lb" "back_end" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_backend_sg_id]
  subnets            = [var.subpub1_id, var.subpub2_id]
  depends_on = [ aws_lb_target_group.back_end ]
  tags = {
    Name = "ALB-backend"
  }
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.back_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_end.arn
  }
  depends_on = [ aws_lb_target_group.back_end ]
}


# resource "aws_lb_listener" "back_end2" {
#   load_balancer_arn = aws_lb.back_end.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.back_end.arn
#   }
#   depends_on = [ aws_lb_target_group.back_end ]
  
# }

######################################################################################

###For frontend TG & ALB 

resource "aws_lb_target_group" "front_end" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = [ var.vpcname ]

}

resource "aws_lb" "front_end" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_frontend_sg-id]
  subnets            = [var.subpub1_id, var.subpub2_id]
 
  tags = {
    Name = "ALB-Frontend"
  }
  depends_on = [ aws_lb_target_group.front_end ]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
  depends_on = [ aws_lb_target_group.front_end ]
}


# resource "aws_lb_listener" "front_end2" {
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.front_end.arn
#   }
#   depends_on = [ aws_lb_target_group.front_end ]

# }
