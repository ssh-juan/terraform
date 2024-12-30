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