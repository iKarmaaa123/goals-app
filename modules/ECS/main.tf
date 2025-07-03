resource "aws_ecs_cluster" "my_aws_ecs_cluster" {
  name = var.ecs_cluster

}

resource "aws_ecs_task_definition" "my_aws_ecs_task_definition" {
  family                   = var.family
  container_definitions    = <<DEFINITION
  [
    {
      "name": "goals-image",
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
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = var.execution_role_arn
}

resource "aws_ecs_service" "my_aws_ecs_service" {
  name            = var.aws_ecs_service_name
  cluster         = aws_ecs_cluster.my_aws_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_aws_ecs_task_definition.arn
  launch_type = var.launch_type
  desired_count   = var.desired_count
  
  network_configuration {
    subnets = var.subnets
    assign_public_ip = var.assign_public_ip
    security_groups = var.security_groups
  }

   load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  tags = {
    name = var.aws_ecs_service_name
  }
}