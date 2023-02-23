resource "aws_ecs_cluster" "ecs_cluster" {
  name = "cluster-frontend"
  tags = var.common_tags
}