variable "domain_name" {
  type    = string
  default = ""
}

variable "validation_method" {
  type    = string
  default = ""
}

variable "certificate_transparency_logging_preference" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "create_before_destroy" {
  type    = bool
  default = true
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