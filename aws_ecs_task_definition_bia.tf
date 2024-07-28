resource "aws_ecs_task_definition" "bia-web" {
  family       = "task-def-bia"
  network_mode = "bridge"

  container_definitions = jsonencode([
    {
      name      = "bia"
      image     = "${aws_ecr_repository.bia.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 80
        }
      ]
      cpu                  = 1024
      memoryReservation    = 400
      environment = [
        {
          name  = "DB_PORT"
          value = "5432"
        },
        {
          name  = "DB_HOST"
          value = "${aws_db_instance.bia.address}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_bia_web.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "bia"
        }
      }
    }
  ])
}