resource "aws_lb" "bia" {
  name               = "bia-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG1.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "tg2-bia" {
  name     = "tg-bia"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc2.id
  target_type = "instance"
  deregistration_delay = 30

  health_check {
    
    enabled = true
    path = "/api/versao"
    interval = 10
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
    matcher = 200
  }
}
resource "aws_lb_listener" "bia" {
  load_balancer_arn = aws_lb.bia.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg2-bia.arn
  }
}

resource "aws_lb_listener" "bia_https" {
  load_balancer_arn = aws_lb.bia.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:730335588602:certificate/49375b4a-4966-4d12-84c3-d17869bb4488"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg2-bia.arn
  }
    depends_on = [aws_lb.bia, aws_lb_target_group.tg2-bia]

}


output "alb_url" { 
  value = aws_lb.bia.dns_name
}