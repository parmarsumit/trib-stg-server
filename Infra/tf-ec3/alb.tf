resource "aws_lb" "default" {
  name               = "${var.tags["Name"]}"
#   internal           = "${var.internal}"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.ec2.id}"]
  subnets            = ["${data.terraform_remote_state.env.private_subnets}"]
  # subnets = ["${var.subnets}"]

  enable_deletion_protection = "false"

  tags = "${var.tags}"
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_lb.default.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-1:933186250239:certificate/1851de8f-c18d-4b27-ab6a-83cfbdf3a9be"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
  }

}
resource "aws_alb_listener" "listener1" {
  load_balancer_arn = "${aws_lb.default.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
  }

}



resource "aws_alb_listener_rule" "listener_rule_0" {
  listener_arn = "${aws_alb_listener.listener.arn}"

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
  }

 condition {
    field  = "path-pattern"
    values = ["/io.ws"]
  }
}
resource "aws_alb_listener_rule" "listener_rule_1" {
  listener_arn = "${aws_alb_listener.listener.arn}"
  # priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
  }

  condition {
    field = "host-header"
    values = ["*.tribute.global"]
  }
}

resource "aws_alb_target_group" "target_group" {
  name                 = "${var.tags["Name"]}"
  port                 = "9999"
  protocol             = "HTTP"
  vpc_id      = "${data.terraform_remote_state.env.vpc_id}"
  stickiness {
      type = "lb_cookie"
      cookie_duration = 86400
      enabled = true
  }

  health_check {
    interval            = 30
    path                = "/"
    matcher             = "200,404,404"
  }

target_type = "instance"

  tags = "${var.tags}"
}


resource "aws_lb_target_group_attachment" "default" {
  target_group_arn = "${aws_alb_target_group.target_group.arn}"
  target_id        = "${aws_instance.ec2.id}"
}