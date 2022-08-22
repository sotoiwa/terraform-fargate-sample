resource "aws_ecs_task_definition" "nginx" {
  family             = "${var.app_name}-taskdef"
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<EOF
[
  {
    "cpu"                   : 256,
    "essential"             : true,
    "image"                 : "nginx",
    "logConfiguration"      : {
      "logDriver" : "awslogs",
      "options"   : {
        "awslogs-group"         : "${var.app_name}",
        "awslogs-region"        : "${data.aws_region.this.name}",
        "awslogs-stream-prefix" : "nginx"
      }
    },
    "memory"                : 512,
    "name"                  : "${var.app_name}",
    "portMappings"          : [
      {
        "containerPort" : 80,
        "hostPort"      : 80,
        "protocol"      : "tcp"
      }
    ]
  }
]
EOF

}
