resource "aws_db_instance" "this" {
  identifier             = var.instance_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.name
  username               = var.username
  password               = random_password.this.result
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  db_subnet_group_name   = aws_db_subnet_group.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
}

resource "aws_security_group" "this" {
  name        = "rds-sg"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = var.rds_protocol
    from_port       = var.rds_port
    to_port         = var.rds_port
    security_groups = [var.allowed_security_groups]
  }
}

resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnet_ids
}

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "this" {
  name  = var.secret_name
  type  = var.secret_type
  value = random_password.this.result
}