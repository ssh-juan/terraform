terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }

  backend "s3" {
    bucket     = "jbs-remote-state"
    key        = "aws-vm-modulo-local/terraform.tfstate"
    region     = "sa-east-1"
    access_key = ""
    secret_key = ""
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

module "network" {
  source = "./network"

  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = "10.0.0.0/24"
  environment = "dev"
}