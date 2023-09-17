
variable "vpc_cidr" {
  type = string
  #default = "10.0.0.0/16"
}
variable "vpc_tags" {
  type = map
  default = {}
}

variable "igw_tags" {
  type = map
  default = {}
}
variable "public_subnet_cidr" {
  type = list
  description = "Please provide 2 public subnet CIDR"
  validation {
    condition = (
    length(var.public_subnet_cidr) == 2
    )
    error_message = "CIDR list must be 2"
  }
}
variable "public_subnet_names"{
  type = list
  description = "Please provide 2 public subnet names"
  #default = []
  validation {
    condition = (
    length(var.public_subnet_names) == 2
    )
    error_message = "Names list must be 2"
  }
}
variable "private_subnet_cidr" {
  type = list
  description = "Please provide 2 private subnet CIDR"
  validation {
    condition = (
    length(var.private_subnet_cidr) == 2
    )
    error_message = "CIDR list must be 2"
  }
}
variable "private_subnet_names"{
  type = list
  description = "Please provide 2 private subnet names"
  #default = []
  validation {
    condition = (
    length(var.private_subnet_names) == 2
    )
    error_message = "Names list must be 2"
  }
}
variable "public_route_table_tags" {
  type = map
  default = {}
}
variable "private_route_table_tags" {
  type = map
  default = {}
}
