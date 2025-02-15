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