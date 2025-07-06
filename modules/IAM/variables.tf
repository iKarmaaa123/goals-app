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
