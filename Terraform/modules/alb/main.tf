 resource "aws_lb" "LCT-ALB" {
  name               = "Threat-Composer-Tool-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
}


resource "aws_alb_listener" "Listener" {
  load_balancer_arn = aws_lb.LCT-ALB.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.target_group_id
    type             = "forward"
  }
}


resource "aws_alb_listener" "ListenerSSL" {
  load_balancer_arn = aws_lb.LCT-ALB.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = var.certificate_arn
   
  default_action {
    target_group_arn = var.target_group_id
    type             = "forward"
  }
}