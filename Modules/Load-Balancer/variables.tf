variable "load_balancer_name" {
  description = "load_balancer_name"
  type = string
}

variable "internal" {
  description = "internal lb"
  type = bool
}

variable "load_balancer_type" {
  description = "load_balancer_type application, network"
  type = string
}

variable "security_groups" {
    description = "security_groups"
    type = list(string)
}

variable "subnets" {
  description = "subnets"
  type = list(string)
}

variable "Environment" {
  description = "Environment"
  type = string
}

variable "target_group_name" {
  description = "target_group_name"
  type = string
}

variable "target_group_port" {
  description = "target_group_port"
  type = string
}


variable "protocol" {
  description = "protocol"
  type = string
}

variable "vpc_id" {
  description = "vpc_id"
  type = string
}