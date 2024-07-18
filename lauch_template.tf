resource "aws_launch_template" "ecs_ec2" {
    name_prefix   = "cluster-bia-web-"
    image_id      = var.ami
    instance_type = var.instance_type_ec2
    vpc_security_group_ids = [aws_security_group.SG1.id]

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_type = "gp3"
            delete_on_termination = true
        }
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name     = "${var.tag_name}-launch"
            App      = "${var.tag_app}-launch"
            Servico  = "${var.tag_servico}-launch"
        }
    }

    iam_instance_profile {
        name = aws_iam_instance_profile.role_acesso_ssm_instance_profile.name
    }

    user_data = base64encode(<<EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.cluster-bia.name} >> /etc/ecs/ecs.config
    EOF
    )
}