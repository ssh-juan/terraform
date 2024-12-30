# Terraform
My Terraform Studies using `v1.10.3`

## Setting Access Keys as Environment Variables
- Configuring Access Keys by setting Environment Variables on various Operational Systems
### AWS
#### Linux
`export AWS_ACCESS_KEY_ID="access_key"`  
`export AWS_SECRET_ACCESS_KEY="secret_access_key"`

#### CMD Windows
`SET AWS_ACCESS_KEY_ID=access_key`  
`SET AWS_SECRET_ACCESS_KEY=secret_access_key`

#### PowerShell Windows
`$env:AWS_ACCESS_KEY_ID="access_key"`  
`$env:AWS_SECRET_ACCESS_KEY="secret_access_key"`

### Azure
#### Linux
`export ARM_CLIENT_ID=client_id`  
`export ARM_TENANT_ID=tenant_id`  
`export ARM_SUBSCRIPTION_ID=subscription_id`  
`export ARM_CLIENT_SECRET=client_secret`

#### CMD Windows
`SET ARM_CLIENT_ID=client_id`  
`SET ARM_TENANT_ID=tenant_id`  
`SET ARM_SUBSCRIPTION_ID=subscription_id`  
`SET ARM_CLIENT_SECRET=client_secret`

#### PowerShell Windows
`$env:ARM_CLIENT_ID="client_id"`  
`$env:ARM_TENANT_ID="tenant_id"`  
`$env:ARM_SUBSCRIPTION_ID="subscription_id"`  
`$env:ARM_CLIENT_SECRET="client_secret"`

## Documentation
- [Languages (HCL and JSON)](https://developer.hashicorp.com/terraform/language)  
The main purpose of the Terraform language is declaring resources, which represent infrastructure objects. All other language features exist only to make the definition of resources more flexible and convenient.
- [Terraform Registry](https://registry.terraform.io/)  
It is a central repository for Terraform modules, providers, policies, and run tasks.
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

### Terraform Block
- Terraform
    - Possible Parameters:  
    `required_version`- Specifies the version(s) of Terraform that can be used with the configuration.  
    `required_provider` - Declares the providers required for the configuration and their versions.  
    `backend`- Configures the backend to store and manage the Terraform state.  
    `cloud` - Configures HCP(HashiCorp Cloud Platform - old Terraform Cloud) for managing state and running plans.  
    `experiments` - Enables experimental or beta features of Terraform.  
    `provider_meta` - Passes metadata to Terraform Providers.
```hcl
#Terraform Block Example
terraform {
  required_version = "~> 1.0.0" #1.0.0 até 1.0.x

  required_providers {
    aws = {
        version = "1.0"
        source = "hashicorp/aws"
    }
    azurerm = {
        version = "2.0"
        source = "hashicorp/aws"
    }
  }

  backend "s3" {
    
  }
}
```

## Main Commands
- `terraform -help` - Displays help for Terraform commands and their usage.
- `init` - Prepare your working directory for other commands.
- `fmt` - Reformat your configuration in the standard style.
- `validate` - Check whether the configuration is valid.
- `plan` - Show changes required by the current configuration.
- `apply` - Create or update infrastructure.
- `destroy` - Destroy previously-created infrastructure.
