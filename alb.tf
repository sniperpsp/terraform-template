# Criação do Load Balancer
resource "aws_lb" "bia" {
  name               = "bia-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

 tags = {
    
    Name = "${var.tag_name}-alb"
    App = "${var.tag_app}-alb"
    Servico = "${var.tag_servico}-alb"

  }
}

# Criação do Security Group para o ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Criação do Target Group
resource "aws_lb_target_group" "bia_tg" {
  name     = "tg-bia"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.vpc2.id

  health_check {
    path                = "/api/versao"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

 tags = {
    
    Name = "${var.tag_name}-alb"
    App = "${var.tag_app}-alb"
    Servico = "${var.tag_servico}-alb"

  }
}

resource "aws_lb_listener" "bia_lb_listener" {
  load_balancer_arn = aws_lb.bia.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bia_tg.arn
  }
}

output "alb_url" {
  value = aws_lb.bia.dns_name
}

# Associação da instância EC2 ao Target Group
resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  target_group_arn = aws_lb_target_group.bia_tg.arn
  target_id        = aws_instance.ec2_tf.id
  port             = 80
}

# Criação do Listener
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.bia.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bia_tg.arn
  }
}