resource "aws_ecs_cluster" "my_aws_ecs_cluster" {
  name = "goals-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "my_aws_ecs_task_definition" {
  family                   = "goals"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "goals",
      "image": "648767092427.dkr.ecr.us-east-1.amazonaws.com/goals-repo:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "goalslogs",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = var.execution_role_arn
}

resource "aws_ecs_service" "my_aws_ecs_service" {
  name            = "goalsecsservice"
  cluster         = aws_ecs_cluster.my_aws_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_aws_ecs_task_definition.arn
  launch_type = "FARGATE"
  desired_count   = 2
  
  network_configuration {
    subnets = var.subnets
    assign_public_ip = false
    security_groups = var.security_groups
  }

   load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "goals"
    container_port   = 80
  }

  tags = {
    Name = "goals-ecs-service"
  }
}