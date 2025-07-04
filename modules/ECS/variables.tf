variable "ecs_cluster" {
  type = string
  default = ""
}

variable "family" {
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
    type = number
    default = 0
}

variable "cpu" {
    type = number
    default = 0
}

variable "aws_ecs_service_name" {
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

variable "execution_role_arn" {
    type = string
    default = ""
}

variable "subnets" {
    type = list
    default = []
}

variable "security_groups" {
    type = list
    default = []
}

variable "target_group_arn" {
    type = string
    default = ""
}



