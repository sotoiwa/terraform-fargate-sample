resource "aws_cloudwatch_log_group" "ecs" {
  name = var.app-name
}
