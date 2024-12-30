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

## Input Variables
Input variables let you customize aspects of Terraform modules without altering the module's own source code. This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable.  

Example:
```hcl
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}
```

Declaring the Variables above:  
Syntax: `var.name_of_variable`
```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.image_id
  instance_type = "t2.micro"

  availability_zone = element(var.availability_zone_names, 0)
}

resource "docker_container" "example" {
  image = "nginx:latest"
  name  = "example-nginx"

  ports {
    internal = var.docker_ports[0].internal
    external = var.docker_ports[0].external
    protocol = var.docker_ports[0].protocol
  }
}

# Declare the variables
variable "region" {
  description = "Region where resources will be provisioned on AWS"
  type        = string
  default     = "us-west-1"
}
```

### Assigning Values to Root Module Variables
When variables are declared in the root module of your configuration, they can be set in a number of ways:
- In an HCP Terraform workspace.
- Individually, with the `-var` command line option.
- In variable definitions (`.tfvars`) files, either specified on the command line or automatically loaded.
- As environment variables.

## Local Values
Local Values in Terraform are variables defined within your configuration file to simplify and modularize the code. They allow you to create values that can be reused in multiple parts of the configuration, which helps avoid repetition and makes the code cleaner and easier to maintain.  

Example:
```hcl
locals {
  common_tags = {
    owner = "juan"
    managed-by = "terraform"
  }
}
```

## Outputs
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.  

Example:
```hcl
output "storage_account_id" {
    description = "Storage Account ID created in Azure"
    value = azurerm_storage_account.storage_account.id
}
```