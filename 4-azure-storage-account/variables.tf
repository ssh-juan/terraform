variable "location" {
  description = "Region where resources will be provisioned on Azure"
  type        = string
  default     = "Brazil South"
}

variable "account_tier" {
  description = "Storage Account Tier on Azure"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Type of Data Replication of Storage Account"
  type        = string
  default     = "LRS"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-terraform"
}

variable "storage_account_name" {
  description = "Storage Account Name"
  type        = string
  default     = "juanborgesterraform" #globally unique
}

variable "container_name" {
  description = "Container Name"
  type        = string
  default     = "container-terraform"

}