# Aqui eu atrelei uma role que eu ja tinha em minha conta ao servidor criado
resource "aws_iam_instance_profile" "role_acesso_ssm_instance_profile" {
  name = "role-acesso-ssm-instance-profile"
  role = "role-acesso-ssm"
}

# Criação de uma role que libera acesso ao SSM
#resource "aws_iam_role" "role_acesso_ssm" {
#  name = "role-acesso-ssm"
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = "sts:AssumeRole"
#        Effect = "Allow"
#        Principal = {
#          Service = "ec2.amazonaws.com"
#        }
#      }
#    ]
#  })
#}
#
## Anexando a política gerenciada do SSM à role
#resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy_attachment" {
#  role       = aws_iam_role.role_acesso_ssm.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#}
#