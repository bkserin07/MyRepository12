resource "aws_lb" "web_lb" {
  name               = "web-lb"
  resource "aws_lb" "prod_lb" {
  name               = "prod-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = module.networking.subnet_ids

  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "prod_target_group" {
  name     = "prod-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.networking.vpc_id
}

resource "aws_lb_listener" "prod_lb_listener" {
  load_balancer_arn = aws_lb.prod_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
  }
}

resource "aws_lb_target_group_attachment" "prod_attachment_1" {
  target_group_arn = aws_lb_target_group.prod_target_group.arn
  target_id        = aws_instance.prod_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "prod_attachment_2" {
  target_group_arn = aws_lb_target_group.prod_target_group.arn
  target_id        = aws_instance.prod_2.id
  port             = 80
}

