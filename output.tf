#Saidas que vão ser apresentadas

output "instance_name"{
    value = aws_instance.ec2_tf.tags
}

output "public_ip" {
    value = aws_instance.ec2_tf.public_ip
}

output "private_ip" {
    value = aws_instance.ec2_tf.private_ip
}

output "SG" {
  value = aws_security_group.SG1
}

output "route_table_tf" {
    value = aws_route.default_route
}