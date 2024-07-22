resource "aws_autoscaling_group" "auto_scaling" {
    name = "bia-auto-scaling"
    vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id] // Corrigido 'di' para 'id'
    min_size = 0
    max_size = 2
    desired_capacity = 1
    health_check_grace_period = 0
    health_check_type = "EC2"
    protect_from_scale_in = false
    launch_template {
        id = aws_launch_template.ecs_ec2.id
        version = "$Latest"
    }
    tag {
      key = "Name"
      value = "${var.tag_name}-scaling"
      propagate_at_launch = true
    }
    tag {
      key = "AmazonECSManaged"
      value = "true"
      propagate_at_launch = true
    }
}
