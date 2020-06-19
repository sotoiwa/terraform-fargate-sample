resource "aws_ecs_service" "ecs" {
  name                               = "${var.app-name}-service"
  cluster                            = aws_ecs_cluster.ecs-cluster.id
  task_definition                    = var.app-name
  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  enable_ecs_managed_tags            = false
  health_check_grace_period_seconds  = 0
  launch_type                        = "FARGATE"
  platform_version                   = "1.3.0"
  scheduling_strategy                = "REPLICA"
  tags                               = {}

  load_balancer {
    container_name   = var.app-name
    container_port   = 80
    target_group_arn = aws_lb_target_group.alb.arn
  }

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.task-sg.id
    ]
    subnets = [
      aws_subnet.private-subnet-a.id,
      aws_subnet.private-subnet-c.id
    ]
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer,
    ]
  }

  depends_on = [
    aws_lb_target_group.alb
  ]
}
