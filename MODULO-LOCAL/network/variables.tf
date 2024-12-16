variable "cidr_vpc" {
  description = "CIDR block para VPC"
  type        = string
}

variable "cidr_subnet" {
  description = "CIDR block para Subnet"
  type        = string
}

variable "environment" {
  description = "Ambiente onde o recurso vai ser utilizado"
  type        = string
}