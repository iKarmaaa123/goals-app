variable "vpc_id" {
    type = string
    default = ""
}

variable "subnets" {
    type = list
    default = []
}

variable "drop_invalid_header_fields" {
    type = bool
    default = false
}

variable "security_groups" {
    type = list
    default = []
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

variable "alb_dns_name" {
    type = string
    default = ""
}

variable "certificate_arn" {
    type = string
    default = ""
}