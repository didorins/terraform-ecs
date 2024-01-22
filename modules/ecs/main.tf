resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-task"
  network_mode             = var.network_mode
  requires_compatibilities = [var.requires_compatibilities]
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn

  container_definitions = jsonencode([{
    name  = var.container_name
    image = var.image
    networkMode = "awsvpc"
    portMappings = [{
      containerPort = "${var.containerPort}"
    }]
  }])
}

resource "aws_ecs_service" "this" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = var.requires_compatibilities
  desired_count   = var.desired_count

  network_configuration {
    assign_public_ip = var.assign_public_ip
    subnets         = var.subnets
    security_groups = [aws_security_group.this.id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.containerPort
  }
}

resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_security_group" "this" {
  name        = "ecs-sg"
  description = "Security group of ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = var.ecs_protocol
    from_port   = var.containerPort
    to_port     = var.containerPort
    security_groups = [var.allowed_ingress_security_groups]
  }

  egress {
    protocol    = var.egress_protocol
    from_port   = var.egressPort
    to_port     = var.egressPort
    cidr_blocks = ["${var.allowed_egress_cidr_blocks}"]
  }
}

resource "aws_iam_role" "this" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action    = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = data.aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}