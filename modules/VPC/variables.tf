
variable "vpc_name" {
  type = string
  default = ""
}

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

variable "ecs_security_group_name" {
  type = string
  default = ""
}

variable "ecs_security_group_tag" {
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

variable "http_default_action_type" {
  type = string
  default = ""
}

variable "alb_security_group_name" {
  type = string
  default = ""
}

variable "alb_security_group_tag" {
  type = string
  default = ""
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



