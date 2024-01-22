resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnets
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_security_group" "this" {
  name        = "${var.lb_name}-sg"
  description = "Security group for the ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = var.lb_protocol
    cidr_blocks = ["${var.allowed_ingress_cidr_blocks}"]
  }

  egress {
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.lb_protocol
    cidr_blocks = ["${var.allowed_ingress_cidr_blocks}"]
  }
}