# Terraform AWS EC2 Template

Este módulo do Terraform provisiona uma infraestrutura na AWS, incluindo VPC, subnets, security groups, instâncias EC2 e um Application Load Balancer (ALB).

## Recursos

- `variables.tf`: Define variáveis reutilizáveis para o projeto.
- `vpc.tf`: Cria uma nova VPC e um Internet Gateway.
- `subnet.tf`: Cria uma subnet dentro da VPC.
- `state_config.tf`: Configura o backend do Terraform.
- `user_data.sh`: Script de inicialização para a instância EC2.
- `sg.tf`: Cria um Security Group para a instância EC2.
- `alb.tf`: Configura um Application Load Balancer (ALB).
- `output.tf`: Define as saídas após a execução do Terraform.
- `main.tf`: Especifica a versão do Terraform e o provedor AWS.
- `iam.tf`: Configura uma role IAM.
- `ec2.tf`: Provisiona uma instância EC2.
- `auto_scaling.tf`: Provisiona um Auto Scaling.
- `website.zip`: Arquivo de contedo estático para o site.
- `ecs.tf`: Provisiona um Cluster ECS.
- `launch_template.tf`: Provisiona uma launch template.
- `rds.tf`: Provisiona um RDS.



## Uso

```hcl
module "ec2_template" {
  source = "github.com/sniperpsp/terraform-template"

  # Defina as variáveis necessárias
  ami_id           = "ami-12345678"
  instance_type    = "t2.micro"
  vpc_id           = "vpc-12345678"
  subnet_id        = "subnet-12345678"
  security_group_id = "sg-12345678"
  # Adicione outras variáveis conforme necessário
}
```

## Inputs

| Nome                | Descrição                                      | Tipo   | Default       | Obrigatório |
|---------------------|------------------------------------------------|--------|---------------|-------------|
| `ami_id`            | ID da AMI para a instância EC2                 | string | n/a           | sim         |
| `instance_type`     | Tipo da instância EC2                          | string | `"t2.micro"`  | não         |
| `vpc_id`            | ID da VPC                                      | string | n/a           | sim         |
| `subnet_id`         | ID da Subnet                                   | string | n/a           | sim         |
| `security_group_id` | ID do Security Group                           | string | n/a           | sim         |
| `user_data`         | Script de inicialização para a instância EC2 | string | ""             | não         |
| `iam_role`          | Nome da role IAM para a instância EC2       | string | ""             | não         |

## Outputs

| Nome                | Descrição                                      |
|---------------------|------------------------------------------------|
| `instance_id`       | ID da instância EC2                            |
| `public_ip`         | IP público da instância EC2                    |
| `security_group_id` | ID do Security Group                           |

## Como Usar

1. **Clone o repositório:**
   ```sh
   git clone https://github.com/sniperpsp/terraform-template
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
├── alb.tf
└── Website.zip
```

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Abra uma issue ou envie um pull request com melhorias e correções.

## Licença

Este projeto está licenciado sob a MIT License. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Feito com ❤️ por [Djair Silva](https://github.com/sniperpsp)