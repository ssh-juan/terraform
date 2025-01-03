# -- VPC Structure --
# VPC
# Subnet
# Internet Gateway
# Route Table
# Route Table Association
# Security Group

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  backend "s3" {
    bucket = "juanborges-remote-state"
    key    = "provider/terraform.tfstate"
    region = "sa-east-1"
  }
}

provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "juan"
      managed-by = "terraform"
    }
  }
}

provider "aws" {
  alias  = "usa"
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "juan"
      managed-by = "terraform"
    }
  }
}

provider "aws" {
  alias  = "australia"
  region = "ap-southeast-2"

  default_tags {
    tags = {
      owner      = "juan"
      managed-by = "terraform"
    }
  }
}

module "vpc" {
  providers = {
    aws.provider_1 = aws.usa
    aws.provider_2 = aws.australia
  }

  source = "./vpc"
}