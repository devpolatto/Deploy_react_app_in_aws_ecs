resource "aws_lb" "application_load_balancer" {
  name               = "react-app-elb"
  load_balancer_type = "application"
  subnets = [
    "${aws_subnet.subnet-public-a.id}",
    "${aws_subnet.subnet-public-b.id}"
  ]

  security_groups = ["${aws_security_group.sg-load-balancer.id}"]
  tags            = var.common_tags
}

resource "aws_lb_target_group" "target_group" {
  name        = "react-app-lb"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id
  health_check {
    matcher = "200,301,302"
    path    = "/"
  }
  tags = var.common_tags
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn # Referencing our target group
  }

  tags = var.common_tags
}