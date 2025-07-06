vpc_cidr_block = "10.0.0.0/16"
cidr_block =  "10.0.1.0/24"
cidr_block2 = "10.0.2.0/24"
cidr_block3 = "10.0.3.0/24"
cidr_block4 = "10.0.4.0/24"
availability_zone = "us-east-1a"
availability_zone2 = "us-east-1b"
vpc_name = "goalsvpc"
destination_cidr_block = "0.0.0.0/0"
vpc_tag = "goalsvpc"
public_subnet_tag = "albsubnet"
public_subnet2_tag = "albsubnet2"
private_subnet_tag = "private-subnet"
private_subnet2_tag = "private-subnet2"
ecs_security_group_tag = "goals-security_group"
ecs_ingress_https_type = "ingress"
ecs_ingress_https_from_port = 443
ecs_ingress_https_to_port = 443
ecs_ingress_https_protocol = "TCP"
ecs_ingress_https_description = "Allow inbound traffic from ALB"
ecs_egress_type = "egress"
ecs_egress_from_port = 0
ecs_egress_to_port = 0
ecs_egress_protocol = "-1"
ecs_egress_cidr_blocks = ["0.0.0.0/0"]
ecs_egress_description = "Allow outbound traffic to ALB"
alb_security_group_tag = "goals-security-group-alb"
alb_ingress_type = "ingress"
alb_ingress_http_from_port = 80
alb_ingress_http_to_port = 80
alb_ingress_http_protocol = "tcp"
alb_ingress_http_cidr_blocks = ["0.0.0.0/0"]
alb_ingress_http_description = "Allow inbound Traffic over port 80"
alb_ingress_https_from_port = 443
alb_ingress_https_to_port = 443
alb_ingress_https_protocol = "tcp"
alb_ingress_https_cidr_blocks =["0.0.0.0/0"]
alb_ingress_https_description = "Allow inbound traffic over port 443"
alb_egress_type = "egress"
alb_egress_from_port = 0
alb_egress_to_port = 0
alb_egress_protocol = "-1"
alb_egress_cidr_blocks = ["0.0.0.0/0"]
alb_egress_description = "Allow outbound traffic to users"
eip_domain = "vpc"
internet_gateway_tag = "goalsinternetgateway"
route_table2_tag = "route-table2"
drop_invalid_header_fields = false
domain_name = "ikarmaaa123.com"
record_name = "ikarmaaa123.com"
record_type = "A"
ttl = 300
evaluate_target_health = true
ecs_cluster = "goals-cluster"
family = "goals"
container_definitions = <<DEFINITION
  [
    {
      "name": "goals-container",
      "image": "648767092427.dkr.ecr.us-east-1.amazonaws.com/goals-image/goals-tracker-application:latest",
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
          "awslogs-group": "goals-logs",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
requires_compatibilities = ["FARGATE"]
network_mode = "awsvpc"
memory = 512
cpu = 256
ecs_service_name = "goals-ecs-service"
launch_type = "FARGATE"
desired_count = 2
assign_public_ip = false
container_name = "goals-container"
container_port = 80
validation_method = "DNS"
certificate_transparency_logging_preference = "ENABLED"
environment = "test"
private_zone = false
allow_overwrite = true
alb_name = "goals-app-alb"
internal = false
load_balancer_type = "application"
target_group_name = "goals-target-group"
target_group_port = 80
target_group_protocol = "HTTP"
target_type = "ip"
health_check_path = "/health"
health_check_matcher = 200
health_check_port = "traffic-port"
healthy_threshold = 3
unhealthy_threshold = 3
health_check_timeout = 5
health_check_interval = 30
http_listener_port = 80
http_listener_protocol = "HTTP"
http_default_action_type = "forward"
http_redirect_port = "443"
http_redirect_protocol = "HTTPS"
http_redirect_status_code = "HTTP_301"
https_listener_port = 443
https_listener_protocol = "HTTPS"
ssl_policy = "ELBSecurityPolicy-2016-08"
https_default_action_type = "forward"
ecs_role_name = "goals-ecs-role"
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
actions = ["sts:AssumeRole"]
principals_type = "Service"
identifiers = ["ecs-tasks.amazonaws.com"]
goals_logs = "goals-logs"
retention_in_days = 365