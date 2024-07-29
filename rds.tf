resource "aws_db_instance" "bia" {
  allocated_storage                     = 20
  auto_minor_version_upgrade            = false
  availability_zone                     = "us-east-1a"
  backup_retention_period               = 0  # Desativando backups
  backup_window                         = null
  ca_cert_identifier                    = "rds-ca-2019"
  copy_tags_to_snapshot                 = false
  db_subnet_group_name                  = aws_db_subnet_group.bia_subnet_group.name
  delete_automated_backups              = false
  deletion_protection                   = false
  enabled_cloudwatch_logs_exports       = []
  engine                                = "postgres"
  engine_version                        = "16.1"
  identifier                            = "bia"
  instance_class                        = "db.t3.micro"
  license_model                         = "postgresql-license"
  maintenance_window                    = "fri:09:41-fri:10:11"
  max_allocated_storage                 = 100
  monitoring_interval                   = 0
  multi_az                              = false
  network_type                          = "IPV4"
  option_group_name                     = "default:postgres-16"
  parameter_group_name                  = "liberacao"
  password                              = null  # Senha definida
  manage_master_user_password           = true
  performance_insights_enabled          = false
  port                                  = 5432
  publicly_accessible                   = true
  skip_final_snapshot                   = true
  storage_encrypted                     = false
  storage_type                          = "gp3"  # Alterado para gp3
  tags ={
    Name     = "${var.tag_name}-db"
    App      = "${var.tag_app}-db"     
    Servico  = "${var.tag_servico}-db"
}
  tags_all                              = {}
  username                              = "postgres"  # Usuário definido
  vpc_security_group_ids                = [aws_security_group.SG1.id]
}

resource "aws_db_subnet_group" "bia_subnet_group" {
  name       = "bia-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  tags = {
    Name     = "${var.tag_name}-db"
    App      = "${var.tag_app}-db"     
    Servico  = "${var.tag_servico}-db"
  }
    lifecycle {
    prevent_destroy = true
}
}
