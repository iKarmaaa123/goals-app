module "vpc" {
  source = "../modules/VPC"
  vpc_name = var.vpc_name
  vpc_tag = var.vpc_tag
  public_subnet_tag = var.public_subnet_tag
  public_subnet2_tag = var.public_subnet2_tag
  private_subnet_tag = var.private_subnet_tag
  private_subnet2_tag = var.private_subnet2_tag
  ecs_security_group_tag = var.ecs_security_group_tag
  ecs_ingress_https_type = var.ecs_ingress_https_type
  ecs_ingress_https_from_port = var.ecs_ingress_https_from_port
  ecs_ingress_https_to_port = var.ecs_ingress_https_to_port
  ecs_ingress_https_protocol = var.ecs_ingress_https_protocol
  ecs_ingress_https_description = var.ecs_ingress_https_description
  ecs_egress_type = var.ecs_egress_type
  ecs_egress_from_port = var.ecs_egress_from_port
  ecs_egress_to_port = var.ecs_egress_to_port
  ecs_egress_protocol = var.ecs_egress_protocol
  ecs_egress_cidr_blocks = var.ecs_egress_cidr_blocks
  ecs_egress_description = var.ecs_egress_description
  alb_security_group_tag = var.alb_security_group_tag
  alb_ingress_type = var.alb_ingress_type
  alb_ingress_http_from_port = var.alb_ingress_http_from_port
  alb_ingress_http_to_port = var.alb_ingress_http_to_port
  alb_ingress_http_protocol = var.alb_ingress_http_protocol
  alb_ingress_http_cidr_blocks = var.alb_ingress_http_cidr_blocks
  alb_ingress_http_description = var.alb_ingress_http_description
  alb_ingress_https_from_port = var.alb_ingress_https_from_port
  alb_ingress_https_to_port = var.alb_ingress_https_to_port
  alb_ingress_https_protocol = var.alb_ingress_https_protocol
  alb_ingress_https_cidr_blocks = var.alb_ingress_https_cidr_blocks 
  alb_ingress_https_description = var.alb_ingress_https_description
  alb_egress_type = var.alb_egress_type
  alb_egress_from_port = var.alb_egress_from_port
  alb_egress_to_port = var.alb_egress_to_port
  alb_egress_protocol = var.alb_egress_protocol
  alb_egress_cidr_blocks = var.alb_egress_cidr_blocks
  alb_egress_description = var.alb_egress_description
  vpc_cidr_block = var.vpc_cidr_block
  cidr_block = var.cidr_block
  cidr_block2 = var.cidr_block2
  cidr_block3 = var.cidr_block3
  cidr_block4 = var.cidr_block4
  availability_zone = var.availability_zone
  availability_zone2 = var.availability_zone2
  eip_domain = var.eip_domain
  internet_gateway_tag = var.internet_gateway_tag
  route_table2_tag = var.route_table2_tag
  destination_cidr_block = var.destination_cidr_block
}

module "alb" {
  source = "../modules/ALB"
  vpc_id = module.vpc.vpc_id
  subnets = [module.vpc.public_subnet_id, module.vpc.public_subnet2_id]
  security_groups = [module.vpc.security_group_alb_id, module.vpc.security_group_ecs_id]
  certificate_arn = module.acm.certificate_arn
  alb_name = var.alb_name
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  target_group_name = var.target_group_name
  target_group_port = var.target_group_port
  target_group_protocol = var.target_group_protocol
  target_type = var.target_type
  health_check_path = var.health_check_path
  health_check_matcher = var.health_check_matcher
  health_check_port = var.health_check_port
  healthy_threshold = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  health_check_timeout = var.health_check_timeout
  health_check_interval = var.health_check_interval
  http_listener_port = var.http_listener_port
  http_listener_protocol = var.http_listener_protocol
  http_default_action_type = var.http_default_action_type
  http_redirect_port = var.http_redirect_port
  http_redirect_protocol = var.http_redirect_protocol
  http_redirect_status_code = var.http_redirect_status_code
  https_listener_port = var.https_listener_port
  https_listener_protocol = var.https_listener_protocol
  ssl_policy = var.ssl_policy
  https_default_action_type = var.https_default_action_type
  drop_invalid_header_fields = var.drop_invalid_header_fields
}

module "route53" {
  source = "../modules/Route53"
  domain_name = var.domain_name
  record_name = var.record_name
  record_type = var.record_type
  records = [module.alb.alb_dns_name]
  alb_dns_name = module.alb.alb_dns_name
  zone_id = module.alb.alb_zone_id
  evaluate_target_health = var.evaluate_target_health
}

module "acm" {
  source = "../modules/ACM"
  domain_name = var.domain_name
  validation_method = var.validation_method
  certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  private_zone = var.private_zone
  ttl = var.ttl
  allow_overwrite = var.allow_overwrite
  environment = var.environment
}

module "iam" {
  source = "../modules/IAM"
  ecs_role_name = var.ecs_role_name
  policy_arn = var.policy_arn
  actions = var.actions
  principals_type = var.principals_type
  identifiers = var.identifiers
}

module "ecs" {
  source = "../modules/ECS"
  execution_role_arn = module.iam.task_execution_role_arn
  subnets = [module.vpc.private_subnet_id, module.vpc.private_subnet2_id]
  security_groups = [module.vpc.security_group_ecs_id, module.vpc.security_group_alb_id]
  target_group_arn = module.alb.target_group_arn
  ecs_cluster = var.ecs_cluster
  family = var.family
  container_definitions = var.container_definitions
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  memory = var.memory
  cpu = var.cpu
  aws_ecs_service_name = var.ecs_service_name
  launch_type = var.launch_type
  desired_count = var.desired_count
  container_name = var.container_name
  container_port = var.container_port
  assign_public_ip = var.assign_public_ip
}

module "cloudwatch" {
  source = "../modules/CloudWatch"
  goals_logs = var.goals_logs
  retention_in_days = var.retention_in_days
}