resource "aws_iam_instance_profile" "role_acesso_ssm_instance_profile" {
  name = "role-acesso-ssm-instance-profile"
  role = "role-acesso-ssm"
}