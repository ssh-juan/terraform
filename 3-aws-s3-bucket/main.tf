terraform {
    required_version = ">= 1.3.0"

    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "sa-east-1"

  default_tags {
    tags = {
        #key = "value"
        owner = "juan"
        managed-by = "terraform"
    }
  }
}