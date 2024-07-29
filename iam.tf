resource "aws_iam_role" "role_acesso_ssm" {
  name = "role-acesso-ssm"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_attachment" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  depends_on = [
    aws_iam_role.role_acesso_ssm
  ]
}

resource "aws_iam_instance_profile" "role_acesso_ssm_instance_profile" {
  name = "role-acesso-ssm-instance-profile"
  role = aws_iam_role.role_acesso_ssm.name

  depends_on = [
    aws_iam_role.role_acesso_ssm,
    aws_iam_role_policy_attachment.role_acesso_ssm_policy_attachment
  ]
}

# Anexando a política AdministratorAccess à role
resource "aws_iam_role_policy_attachment" "role_acesso_ssm_admin_policy_attachment" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  depends_on = [
    aws_iam_role.role_acesso_ssm
  ]
}