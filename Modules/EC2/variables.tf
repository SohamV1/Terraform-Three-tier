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

variable "vpc_security_group_ids" {
    description = "list of security group ids to attach to the instance"
    type = list(string)
}

variable "subnet_id" {
    description = "subnet ID where the instance will be launched"
    type = string
}
