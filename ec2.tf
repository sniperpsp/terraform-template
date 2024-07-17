provider "aws" {
  region = "us-east-1"
  profile = "bia"  #troque par ao nome do seu perfil que foi configurado no aws configure
}

resource "aws_instance" "ec2_tf" {
  ami                          = var.ami  #Versão da AMI que estou tulizando, você deve trocar para a sua AMI ou pegar uma padrão na aws.
  instance_type                = var.instance_type_ec2 #Tipo da instancia, a versão t3.micro é freetier então fiquei tranquilo.
  associate_public_ip_address  = true #associar uk ip publico na maquina para acesso web
  disable_api_termination      = true #aqui desabilitei a proteção de terminate na maquina se habilitar você vai ter dificuldade em destruir o ambiente.
  subnet_id                    = aws_subnet.subnet1.id #estou apontando a subnet que criei no arquivo subnet.tf
  security_groups              = [aws_security_group.SG1.id] #apontando o SG que eu criei no sg.tf
  user_data                    = file("user_data.sh") #arquivo onde tem todas as configurações que vão ser aplicadas no ec2 ao ser criado
  get_password_data = false
  iam_instance_profile        = aws_iam_instance_profile.role_acesso_ssm_instance_profile.name #associando o iam que criei no arquico iam.tf ao ec2
  root_block_device {
    volume_type           = "gp3"  #escolhendo o tipo do volume como gp3
    delete_on_termination = true  #habilitando para o disco ser excluido ao terminar o ec2
  }
  
  tags = {
    Name     = var.tag_name
    App      = var.tag_app     #tags para o serviço do ec2 e ebs
    Servico  = var.tag_servico
  }
}