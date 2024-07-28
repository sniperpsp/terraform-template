data "aws_secretsmanager_secret" "biaDB" {
  arn = tolist(aws_db_instance.bia.master_user_secret)[0].secret_arn
}