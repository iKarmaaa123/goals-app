vpc_cidr_block = "10.0.0.0/16"
cidr_block =  "10.0.1.0/24"
cidr_block2 = "10.0.2.0/24"
cidr_block3 = "10.0.3.0/24"
cidr_block4 = "10.0.4.0/24"
availability_zone = "us-east-1a"
availability_zone2 = "us-east-1b"
drop_invalid_header_fields = false
domain_name = "ikarmaaa123.com"
record_name = "ikarmaaa123.com"
record_type = "A"
ttl = 300
ecs_cluster = "goals-cluster"
family = "goals"
requires_compatibilities = ["FARGATE"]
network_mode = "awsvpc"
memory = 512
cpu = 256
ecs_service_name = "goals-ecs-service"
launch_type = "FARGATE"
desired_count = 2
assign_public_ip = false
container_name = "goals"
container_port = 80



