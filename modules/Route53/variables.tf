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

variable "zone_id" {
    type = string
    default = ""
}

variable "evaluate_target_health" {
  type = bool
  default = true
}

variable "alb_dns_name" {
    type = string
    default = ""
}

variable "certificate_arn" {
    type = string
    default = ""
}