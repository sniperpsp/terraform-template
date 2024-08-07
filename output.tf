#Saidas que vão ser apresentadas

output "instance_dns"{
    value = aws_instance.ec2_tf.public_dns
}
output "instance_rds_dns"{
    value = aws_db_instance.bia.endpoint
}

output "public_ip" {
    value = aws_instance.ec2_tf.public_ip
}

output "private_ip" {
    value = aws_instance.ec2_tf.private_ip
}

output "rds" {
  value = aws_db_instance.bia.id
}
output "rds_user" {
      value = aws_db_instance.bia.username  
}

output "bia_repo_url" {
  value = aws_ecr_repository.bia.repository_url
}

output "rds_secret_name" {
  description = "Secret RDS"
  value       = data.aws_secretsmanager_secret.biaDB.name
}

# output "rdds-secret" {
#   value = tolist(aws_db_instance.bia.master_user_secret)[0].secret_arn
  
# }