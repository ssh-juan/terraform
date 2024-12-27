terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
}

provider "aws" {
  region     = "sa-east-1"
  access_key = ""
  secret_key = ""

  default_tags {
    tags = {
      owner      = "juan"
      managed-by = "terraform"
    }
  }
}
