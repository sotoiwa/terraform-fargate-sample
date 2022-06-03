resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
  tags = {
    "Name" = "${var.app_name}-cluster"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
