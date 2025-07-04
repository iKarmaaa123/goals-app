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

variable "ttl" {
    type = number
    default = 0
}

variable "records" {
    type = list
    default = []
}

variable "dns_alb_name" {
    type = string
    default = ""
}

variable "zone_id" {
    type = string
    default = ""
}

variable "drop_invalid_header_fields" {
    type = bool
    default = false
}

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
