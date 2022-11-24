resource "aws_alb" "one_alb" {
  name            = "one-alb"
  security_groups = ["sg-058062c1103a1f60f"]
  subnets         = ["subnet-03fc813c6be74e950", "subnet-08e40fe5d9d2a7124"]
  tags = {
    Name = "one_alb"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "one-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0e6cf35bccf8ecdf8"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}


resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = "${aws_alb.one_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_alb_target_group.group.arn}"
  target_id        = aws_instance.one.id
  port             = 80
}