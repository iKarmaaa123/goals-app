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


