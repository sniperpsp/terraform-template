#Salvando os arquivos tfstate localmente caso queira usar o s3 o codigo já esta comentado

terraform {
  backend "local" {
    #bucket = "bucket-teste124"
    #key = "terraformstate/terraform.tfstate"
    #region = "us-east-1"
    #profile = "bia"
  }

    #backend "s3" {
    #bucket = "bucket-teste124"
    #key = "terraformstate/terraform.tfstate"
    #region = "us-east-1"
    #profile = "bia"
  }