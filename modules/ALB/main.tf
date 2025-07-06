resource "aws_lb" "my_aws_lb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  drop_invalid_header_fields = var.drop_invalid_header_fields
  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "my_aws_lb_target_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  target_type = var.target_type
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    matcher             = var.health_check_matcher
    port                = var.health_check_port
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_aws_lb.arn
  port              = var.http_listener_port
  protocol          = var.http_listener_protocol

  default_action {
    target_group_arn = aws_lb_target_group.my_aws_lb_target_group.arn
    type = var.http_default_action_type
    
    redirect {
      port        = var.http_redirect_port
      protocol    = var.http_redirect_protocol
      status_code = var.http_redirect_status_code
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.my_aws_lb.arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.https_default_action_type
    target_group_arn = aws_lb_target_group.my_aws_lb_target_group.arn
  }
}


