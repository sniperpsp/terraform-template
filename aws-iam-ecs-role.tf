data "aws_iam_role" "ecs_instance_role" {
  name = "role-acesso-ssm"
}

data "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "role-acesso-ssm-instance-profile"
}

resource "aws_iam_policy_attachment" "ssm_managed_instance_core" {
  name       = "ssm-managed-instance-core"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  roles      = [data.aws_iam_role.ecs_instance_role.name]
}