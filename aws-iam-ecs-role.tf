resource "aws_iam_role" "ecs_instance_role" {
  name = "role-acesso-ssm"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "role-acesso-ssm-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_policy_attachment" "ssm_managed_instance_core" {
  name       = "ssm-managed-instance-core"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [aws_iam_role.ecs_instance_role.name]
}