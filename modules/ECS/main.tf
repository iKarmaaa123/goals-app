resource "aws_ecs_cluster" "my_aws_ecs_cluster" {
  name = var.ecs_cluster
}

resource "aws_ecs_task_definition" "my_aws_ecs_task_definition" {
  family                   = var.family
  container_definitions    = var.container_definitions
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