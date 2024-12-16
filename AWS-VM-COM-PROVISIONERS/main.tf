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
    key        = "aws-vm/terraform.tfstate"
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

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket     = "jbs-remote-state"
    key        = "aws-vpc/terraform.tfstate"
    region     = "sa-east-1"
    access_key = ""
    secret_key = ""
  }
}