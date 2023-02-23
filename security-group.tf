resource "aws_security_group" "sg-load-balancer" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - 001 - Load Balancer"
  description = "internet source access"
  vpc_id      = local.vpc_id

  tags = var.common_tags
}
resource "aws_security_group_rule" "http_from_net_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-load-balancer.id
}
resource "aws_security_group_rule" "allowed_all_traffic_to_net" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-load-balancer.id
}
// ==============================================================

// ==============================================================

resource "aws_security_group" "sg_ecs" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - 010 - ECS"
  description = "internet source access"
  vpc_id      = local.vpc_id

  tags = var.common_tags
}

# resource "aws_security_group_rule" "allowed_traffic_from_load_balancer" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"

#   security_groups = ["${aws_security_group.sg-load-balancer.id}"]

#   security_group_id = aws_security_group.sg_ecs.id
# }

# resource "aws_security_group_rule" "allowed_traffic_to_net" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks = ["0.0.0.0/0"]

#   security_group_id = aws_security_group.sg_ecs.id
# }