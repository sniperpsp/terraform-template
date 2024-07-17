// subnet.tf

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "172.0.1.0/24"
  availability_zone = "us-east-1a"
tags = {
    Name     = var.tag_name
    App      = var.tag_app
    Servico  = var.tag_servico
  }
}
 resource "aws_route_table_association" "subnet1_association" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_vpc.vpc2.main_route_table_id
 }