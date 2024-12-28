# Terraform
My Terraform Studies using `v1.10.3`

## Setting Access Keys as Environment Variables
- Configuring Access Keys by setting Environment Variables on various Operational Systems
### Linux
`export AWS_ACCESS_KEY_ID="access_key"`  
`export AWS_SECRET_ACCESS_KEY="secret_access_key"`

### CMD Windows
`SET AWS_ACCESS_KEY_ID=access_key`  
`SET AWS_SECRET_ACCESS_KEY=secret_access_key`

### PowerShell Windows
`$env:AWS_ACCESS_KEY_ID="access_key"`  
`$env:AWS_SECRET_ACCESS_KEY="secret_access_key"`

## Documentation
- [Languages (HCL and JSON)](https://developer.hashicorp.com/terraform/language)  
The main purpose of the Terraform language is declaring resources, which represent infrastructure objects. All other language features exist only to make the definition of resources more flexible and convenient.
- [Providers](https://registry.terraform.io/browse/providers)  
Providers are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources.
- [Modules](https://registry.terraform.io/browse/modules)  
Modules are self-contained packages of Terraform configurations that are managed as a group.

## Files Structure
- Hidden Directory `.terraform` - Directory where the Modules and Providers are saved
- File `.tfvars` - Declare variables
- File `.tfstate` - Save the current state of the infrastructure
- File `.tfstate.backup` - Save the previous state from the current state
- File `.terraform.lock.hcl` - Is a "dependency lock file", used to control the versions of our Providers

## Block Structure of HCL Language
Types of Blocks:

- Terraform
- Providers
- Resources
- Data
- Module
- Variable
- Output
- Locals
```hcl
terraform {
  
}

provider "aws" {
  
}

resource "aws_instance" "vm1" {
  
}

data "aws_ami" "image" {
  
}

module "network" {
  
}

variable "vm_name" {
  
}

output "vm1_ip" {
  
}

locals {
  
}
```