data "aws_secretsmanager_secret" "rds_password" {
  name = var.rds_password_secret_name
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

resource "aws_db_subnet_group" "default" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_db_instance" "default" {
  identifier = var.identifier
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.instance_type
  username             = var.rds_username
  password             = data.aws_secretsmanager_secret_version.secret-version.secret_string
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot  = var.skip_final_snapshot
  vpc_security_group_ids = var.security_group_ids
  
  tags = {
    Name = var.db_name
    Environment = var.Environment
  }
}

resource "aws_db_instance" "default_replica" {
  replicate_source_db = aws_db_instance.default.identifier
  identifier = var.identifier_replica
  instance_class       = var.instance_type
  skip_final_snapshot  = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  vpc_security_group_ids = var.security_group_ids
}