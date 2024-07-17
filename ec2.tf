provider "aws" {
  region = "us-east-1"
  profile = "bia"
}

resource "aws_instance" "ec2_tf" {
  ami                          = var.ami
  instance_type                = var.instance_type_ec2
  associate_public_ip_address  = true
  disable_api_termination      = true
  key_name                     = "keylinux"
  subnet_id                    = aws_subnet.subnet1.id
  security_groups              = [aws_security_group.SG1.id]
  user_data                    = file("user_data.sh")
  get_password_data = false
  iam_instance_profile        = aws_iam_instance_profile.role_acesso_ssm_instance_profile.name
  root_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
  }
  
  tags = {
    Name     = var.tag_name
    App      = var.tag_app
    Servico  = var.tag_servico
  }
}