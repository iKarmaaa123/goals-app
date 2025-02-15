resource "aws_lb" "my_aws_lb" {
  name               = "goals-alb"
  internal           =  false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Environment = "goals-prod"
  }
}

resource "aws_lb_target_group" "my_aws_lb_target_group" {
  name     = "goals-target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
  health_check {
    path = "/health"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_aws_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"
    
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.my_aws_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_aws_lb_target_group.arn
  }
}


