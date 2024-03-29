resource "aws_lb_target_group" "this" {
  name                 = "${var.app_name}-tg"
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = aws_vpc.this.id
  deregistration_delay = 30

  health_check {
    interval            = 6
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }

  depends_on = [aws_lb.this]
}
