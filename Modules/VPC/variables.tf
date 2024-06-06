variable "vpc_cidr" {
    description = "VPC CIDR"
    type = string
}


variable "vpc_name" {
    description = "VPC Name"
    type = string
}
 
variable "public_subnet_cidr_block" {
    description = "public_subnet_cidr_block"
    type = string
}

variable "public_sub_availability_zone" {
    description = "public_sub_availability_zone"
    type = string
}

variable "public_subnet_name" {
    description = "public_subnet_name"
   type = string
}

variable "private_subnet_cidr_block" {
    description = "private_subnet_cidr_block"
    type = string
}

variable "private_sub_availability_zone" {
    description = "private_sub_availability_zone"
  type = string
}

variable "private_subnet_name" {
    description = "private_subnet_name"
   type = string
}

variable "private_subnet_cidr_block_2" {
  description = "private_subnet_cidr_block for second subnet"
  type = string
}

variable "private_sub_availability_zone_2" {
  description = "private_sub_availability_zone_2"
  type = string
}

variable "private_subnet_name_2" {
  description = "private_subnet_name_2"
  type = string
}

variable "public_subnet_cidr_block_2" {
    description = "public_subnet_cidr_block_2"
    type = string
}

variable "public_sub_availability_zone_2" {
    description = "public_sub_availability_zone_2"

    type = string
}

variable "public_subnet_name_2" {
    description = "public_subnet_name_2"
   type = string
}