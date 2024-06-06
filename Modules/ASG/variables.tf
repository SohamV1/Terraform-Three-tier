variable "ami" {
    description = "AMI ID for the instance"
    type = string
}

variable "instance_type" {
    description = "Instance type"
    type = string
}

variable "key_name" {
    description = "Key name to attach the instance"
    type = string
}

variable "instance_name" {
    description = "Instance Name"
    type = string
}

# variable "user_data" {
#     description = "User data for the instance"
#     type = string
# }

variable "Environment" {
    description = "Enviornment in which the instance will be launched"
    type = string
}

variable "security_groups" {
    description = "list of security group ids to attach to the instance"
    type = list(string)
}


variable "alb_group_name" {
    description = "alb_group_name"
    type = string
}

variable "max_size" {
    description = "max number of instances in asg group"
    type = number
}

variable "min_size" {
    description = "min number of instances in asg group"
    type = number
}

variable "health_check_type" {
  description = "health_check_type"
  type = string
}

variable "desired_capacity" {
    description = "desired_capacity of instances in asg"
    type = number
}

variable "lb_target_group_arns" {
  description = "lb_target_group_arns"
  type = list(string)
}

variable "subnets_alb" {
  description = "subnets_alb"
  type = list(string)
}

variable "asg_policy_name" {
  description = "asg_policy_name"
  type = string
}

variable "policy_type" {
  description = "policy_type"
  type = string
}

variable "predefined_metric_type" {
  description = "predefined_metric_type"
  type = string
}

variable "target_value" {
    description = "target_value"
    type = number
}