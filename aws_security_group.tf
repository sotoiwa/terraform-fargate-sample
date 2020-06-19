resource "aws_security_group" "task-sg" {
  name   = "${var.app-name}-task-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "task-sg" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb-sg.id
  security_group_id        = aws_security_group.task-sg.id
}

resource "aws_security_group_rule" "task-sg-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.task-sg.id
}

resource "aws_security_group" "alb-sg" {
  name   = "${var.app-name}-alb-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "alb-sg" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "alb-sg-2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}
