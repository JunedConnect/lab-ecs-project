resource "aws_ecs_cluster" "TCT-Cluster" {
  name = "Threat-Composer-Tool-Cluster"

}


resource "aws_ecs_service" "TCD-Service" {
  name                               = "MyService"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = aws_ecs_cluster.TCT-Cluster.id
  task_definition                    = aws_ecs_task_definition.TCD-TD.id
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1

  network_configuration {
    assign_public_ip = true
    security_groups  = [var.security_group_id]
    subnets          = ["subnet-0967fd07e590e573d", "subnet-01c138da85041dd7e", "subnet-093f680cc56a25613"]
  }


  load_balancer {
    target_group_arn = var.target_group_id
    container_name   = "container"
    container_port   = 3000
  }
}


resource "aws_ecs_task_definition" "TCD-TD" {
  family                   = "Threat-Composer-Tool-TD"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::677276074604:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  container_definitions = jsonencode([
    {
      name      = "container"
      image     = "677276074604.dkr.ecr.eu-west-2.amazonaws.com/threat-composer-tool:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}