variable "availability_zone" {
    type = string
    default = ""
}

variable "availability_zone2" {
    type = string
    default = ""
}

variable "vpc_cidr_block" {
    type = string
    default = ""
}

variable "cidr_block" {
    type = string
    default = ""
}

variable "cidr_block2" {
    type = string
    default = ""
}

variable "cidr_block3" {
    type = string
    default = ""
}

variable "cidr_block4" {
    type = string
    default = ""
}

variable "destination_cidr_block" {
  type = string
  default = ""
}

variable "domain_name" { 
    type = string
    default = ""
}

variable "record_name" {
    type = string
    default = ""
}

variable "record_type" {
    type = string
    default = ""
}

variable "evaluate_target_health" {
  type = bool
  default = true
}

variable "ecs_cluster" {
  type = string
  default = ""
}

variable "family" {
    type = string
    default = ""  
}

variable "container_definitions" {
  type = string
  default = ""
}

variable "requires_compatibilities" {
    type = list(string)
    default = []
}

variable "network_mode" {
    type = string
    default = ""
}

variable "memory" {
    type = string
    default = ""
}

variable "cpu" {
    type = string
    default = ""
}

variable "ecs_service_name" {
  type = string
  default = ""
}

variable "launch_type" {
  type = string
  default = ""
}

variable "desired_count" {
  type = number
  default = 0
}

variable "assign_public_ip" {
  type = bool
  default = true
}

variable "container_name" {
  type = string
  default = ""
}

variable "container_port" {
  type = number
  default = 0
}

variable "validation_method" {
  type    = string
  default = ""
}

variable "certificate_transparency_logging_preference" {
  type    = string
  default = ""
}

variable "private_zone" {
  type    = bool
  default = false
}

variable "allow_overwrite" {
  type    = bool
  default = true
}

variable "ttl" {
  type    = number
  default = 0
}

variable "vpc_name" {
  type = string
  default = ""
}

variable "vpc_tag" {
  type = string
  default = ""
}

variable "public_subnet_tag" {
  type = string
  default = ""
}

variable "public_subnet2_tag" {
  type = string
  default = ""
}

variable "private_subnet_tag" {
  type = string
  default = ""
}

variable "private_subnet2_tag" {
  type = string
  default = ""
}

variable "ecs_security_group_tag" {
  type = string
  default = ""
}

variable "alb_security_group_tag" {
  type = string
  default = ""
}

variable "ecs_ingress_https_type" {
  type = string
  default = ""
}

variable "ecs_ingress_https_from_port" {
  type = string
  default = ""
}

variable "ecs_ingress_https_to_port" {
  type = string
  default = ""
}

variable "ecs_ingress_https_protocol" {
  type = string
  default = ""
}

variable "ecs_ingress_https_description" {
  type = string
  default = ""
}

variable "ecs_egress_type" {
  type = string
  default = "egress"
}

variable "ecs_egress_from_port" {
  type = number
  default = 0
}

variable "ecs_egress_to_port" {
  type = number
  default = 0
}

variable "ecs_egress_protocol" {
  type = string
  default = "-1"
}

variable "ecs_egress_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "ecs_egress_description" {
  type = string
  default = "Allow outbound traffic from ECS"
}

variable "alb_ingress_type" {
  type = string
  default = ""
}

variable "alb_ingress_http_from_port" {
  type = number
  default = 0
}

variable "alb_ingress_http_to_port" {
  type = number
  default = 0
}

variable "alb_ingress_http_protocol" {
  type = string
  default = ""
}

variable "alb_ingress_http_cidr_blocks" {
  type = list(string)
  default = [""]
}

variable "alb_ingress_http_description" {
  type = string
  default = ""
}

variable "alb_ingress_https_from_port" {
  type = number
  default = 0
}

variable "alb_ingress_https_to_port" {
  type = number
  default = 0
}

variable "alb_ingress_https_protocol" {
  type = string
  default = ""
}

variable "alb_ingress_https_cidr_blocks" {
  type = list(string)
  default = [""]
}

variable "alb_ingress_https_description" {
  type = string
  default = ""
}

variable "alb_egress_type" {
  type = string
  default = ""
}

variable "alb_egress_from_port" {
  type = number
  default = 0
}

variable "alb_egress_to_port" {
  type = number
  default = 0
}

variable "alb_egress_protocol" {
  type = string
  default = ""
}

variable "alb_egress_cidr_blocks" {
  type = list(string)
  default = [""]
}

variable "alb_egress_description" {
  type = string
  default = ""
}

variable "eip_domain" {
  type = string
  default = ""
}

variable "internet_gateway_tag" {
  type = string
  default = ""
}

variable "route_table2_tag" {
  type = string
  default = ""
}

variable "alb_name" {
  type    = string
  default = ""
}

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
  default = ""
}

variable "drop_invalid_header_fields" {
  type    = bool
  default = false
}

variable "environment" {
  type    = string
  default = ""
}

variable "target_group_name" {
  type    = string
  default = ""
}

variable "target_group_port" {
  type    = number
  default = 0
}

variable "target_group_protocol" {
  type    = string
  default = ""
}

variable "target_type" {
  type    = string
  default = ""
}

variable "health_check_path" {
  type    = string
  default = ""
}

variable "health_check_matcher" {
  type    = number
  default = 0
}

variable "health_check_port" {
  type    = string
  default = ""
}

variable "healthy_threshold" {
  type    = number
  default = 0
}

variable "unhealthy_threshold" {
  type    = number
  default = 0
}

variable "health_check_timeout" {
  type    = number
  default = 0
}

variable "health_check_interval" {
  type    = number
  default = 0
}

variable "http_listener_port" {
  type    = number
  default = 0
}

variable "http_listener_protocol" {
  type    = string
  default = ""
}

variable "http_default_action_type" {
  type    = string
  default = ""
}

variable "http_redirect_port" {
  type    = string
  default = ""
}

variable "http_redirect_protocol" {
  type    = string
  default = ""
}

variable "http_redirect_status_code" {
  type    = string
  default = ""
}

variable "https_listener_port" {
  type    = number
  default = 0
}

variable "https_listener_protocol" {
  type    = string
  default = ""
}

variable "ssl_policy" {
  type    = string
  default = ""
}

variable "https_default_action_type" {
  type    = string
  default = ""
}

variable "ecs_role_name" {
    type = string
    default = ""
}

variable "policy_arn" {
    type = string
    default = ""
}

variable "actions" {
  type = list(string)
  default = [""]
}

variable "principals_type" {
  type = string
  default = ""
}

variable "identifiers" {
  type = list(string)
  default = [""]
}

variable "goals_log_name" {
  type = string
  default = ""
}

variable "goals_log_stream_name" {
  type = string
  default = ""
}

variable "retention_in_days" {
  type = number
  default = 0
}

