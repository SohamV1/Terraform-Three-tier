resource "aws_lb" "my-lb" {
  name               = var.load_balancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    "Name" = var.load_balancer_name
    "Enviornment" = var.Environment
  }
}

resource "aws_lb_target_group" "test" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = var.target_group_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
