variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnets" {
  type    = list(string)
  default = []
}

variable "drop_invalid_header_fields" {
  type    = bool
  default = false
}

variable "security_groups" {
  type    = list(string)
  default = []
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
  default = "application"
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

variable "certificate_arn" {
  type    = string
  default = ""
}