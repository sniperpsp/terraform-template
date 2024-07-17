# Terraform AWS EC2 Template

Este projeto utiliza Terraform para provisionar uma infraestrutura na AWS, incluindo VPC, subnets, security groups, instâncias EC2 e mais. Abaixo está uma descrição detalhada dos arquivos e suas funcionalidades.

## Arquivos e Funcionalidades

### `variables.tf`
Define variáveis reutilizáveis para o projeto, como nomes de tags, ID da AMI, tipo de instância, IP do usuário e nome do Security Group.

### `vpc.tf`
Cria uma nova VPC e um Internet Gateway, além de configurar a tabela de rotas para permitir tráfego de saída.

### `subnet.tf`
Cria uma subnet dentro da VPC e associa a tabela de rotas principal à subnet.

### `state_config.tf`
Configura o backend do Terraform para armazenar o estado localmente. Há uma configuração comentada para usar o S3 como backend.

### `user_data.sh`
Script de inicialização para a instância EC2. Configura um usuário, habilita login via senha, instala Apache, baixa e configura um site.

### `sg.tf`
Cria um Security Group para a instância EC2, permitindo tráfego HTTP e SSH.

### `output.tf`
Define as saídas que serão exibidas após a execução do Terraform, como IPs públicos e privados da instância EC2 e detalhes do Security Group.

### `main.tf`
Especifica a versão do Terraform e o provedor AWS a ser utilizado.

### `iam.tf`
Configura uma role IAM para permitir acesso ao SSM (AWS Systems Manager) pela instância EC2.

### `ec2.tf`
Provisiona uma instância EC2 com as configurações definidas, incluindo AMI, tipo de instância, subnet, security group, script de inicialização e perfil IAM.

## Como Usar

1. **Clone o repositório:**
   ```sh
   git clone https://github.com/sniperpsp/terraform-template.git
   cd terraform-template
   ```

2. **Configure suas credenciais AWS:**
   Certifique-se de que suas credenciais AWS estão configuradas corretamente usando `aws configure`.

3. **Modifique as variáveis conforme necessário:**
   Edite o arquivo `variables.tf` para ajustar as variáveis de acordo com suas necessidades.

4. **Inicialize o Terraform:**
   ```sh
   terraform init
   ```

5. **Planeje a infraestrutura:**
   ```sh
   terraform plan
   ```

6. **Aplique a infraestrutura:**
   ```sh
   terraform apply
   ```

## Estrutura do Projeto
```	
pasta_Clonada/
├── variables.tf
├── vpc.tf
├── subnet.tf
├── state_config.tf
├── user_data.sh
├── sg.tf
├── output.tf
├── main.tf
├── iam.tf
└── ec2.tf
└── Website.zip
```	

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Abra uma issue ou envie um pull request com melhorias e correções.

## Licença

Este projeto está licenciado sob a MIT License. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Feito com ❤️ por [Djair Silva](https://github.com/sniperpsp)