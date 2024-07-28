resource "aws_autoscaling_group" "ecs" {
name_prefix = "cluster-bia-tf-"
vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
min_size = 0
desired_capacity = 1
max_size = 2
health_check_grace_period = 0
health_check_type = "EC2"
protect_from_scale_in = false

launch_template {
  id = aws_launch_template.ecs_ec2.id
  version = "$Latest"
}

tag{
    key = "Name"
    value = "cluster-bia-tf"
    propagate_at_launch = true
}

tag{
    key = "AmazonECSManaged"
    value = ""
    propagate_at_launch = true
}
}
