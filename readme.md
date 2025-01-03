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

## More Commands
- `show` - is used to provide **human-readable output** from a state or plan file. This can be used to inspect a plan to ensure that the planned operations are expected, or to inspect the current state as Terraform sees it.
- `state` -  is used for advanced state management. As your Terraform usage becomes more advanced, there are some cases where you may need to modify the Terraform state. Rather than modify the state directly, the `terraform state` commands can be used in many cases instead.
- `import` - Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management.
- `refresh` - The `terraform refresh` command reads the current settings from all managed remote objects and updates the Terraform state to match.
- `get` - The `get` command is used to download and update modules mentioned in the root module.
- `console` - The `terraform console` command provides an interactive console for evaluating expressions.

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

## Terraform State
Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.
- Remote state is implemented by a [**backend**](https://developer.hashicorp.com/terraform/language/backend) or by HCP Terraform, both of which you can configure in your configuration's root module.

### Backend Block
The backend defines where Terraform stores its state data files.
#### Defining a Backend Block
To configure a backend, add a nested backend block within the top-level terraform block. The following example configures the remote backend.
```hcl
#S3 Example
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

### Terraform Remote State Data Source
The `terraform_remote_state` data source uses the latest state snapshot from a specified state backend to retrieve the root module **output** values from some other Terraform configuration.

## Provisioners
You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.  
** **Provisioners are a last resource.**
** **Instead, use user-data at AWS.**

## Modules
Modules are containers for multiple resources that are used together. A module consists of a collection of `.tf` and/or `.tf.json` files kept together in a directory.
Modules are the main way to package and reuse resource configurations with Terraform.
- Local Modules
- Remote Modules

## Meta Arguments
Meta-arguments are special parameters used in resource blocks to control how resources are created and managed. They provide a way to dynamically configure resources and make your Terraform configurations more flexible and reusable.

### Kinds of Meta Arguments
- Resource
  - depends_on
  - count
  - for_each
  - provider
  - lifecycle
- Module
  - depends_on
  - count
  - for_each
  - provider

#### - depends_on
Use the `depends_on` meta-argument to handle hidden resource or module dependencies that Terraform cannot automatically infer. You only need to explicitly specify a dependency when a resource or module relies on another resource's behavior but does not access any of that resource's data in its arguments.

#### - count
`count` is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.  
The `count` meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
```hcl
resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}
```

#### - for_each
`for_each` is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.  
The `for_each` meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
```hcl
# my_buckets.tf
module "bucket" {
  for_each = toset(["assets", "media"])
  source   = "./publish_bucket"
  name     = "${each.key}_bucket"
}
```

#### - providers
The `provider` meta-argument specifies which provider configuration to use for a resource, overriding Terraform's default behavior of selecting one based on the resource type name. Its value should be an unquoted `<PROVIDER>.<ALIAS>` reference.  
By default, Terraform interprets the initial word in the resource type name (separated by underscores) as the local name of a provider, and uses that provider's default configuration. For example, the resource type `google_compute_instance` is associated automatically with the default configuration for the provider named `google`.  
By using the provider meta-argument, you can select an alternate `provider` configuration for a resource:
```hcl
# default configuration
provider "google" {
  region = "us-central1"
}

# alternate configuration, whose alias is "europe"
provider "google" {
  alias  = "europe"
  region = "europe-west1"
}

resource "google_compute_instance" "example" {
  # This "provider" meta-argument selects the google provider
  # configuration whose alias is "europe", rather than the
  # default configuration.
  provider = google.europe

  # ...
}
```

#### - lifecycle
`lifecycle` is a nested block that can appear within a resource block. The `lifecycle` block and its contents are meta-arguments, available for all `resource` blocks regardless of type.  
The arguments available within a `lifecycle` block are `create_before_destroy`, `prevent_destroy`, `ignore_changes`, and `replace_triggered_by`.

```hcl
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    create_before_destroy = true
  }
}
```

## Functions and Expressions

### Conditional Expressions
A conditional expression uses the value of a boolean expression to select one of two values.  
The syntax of a conditional expression is as follows:
```hcl
condition ? true_val : false_val
```
If `condition` is `true` then the result is `true_val`. If `conditio` is `false` then the result is `false_val`.

A common use of conditional expressions is to define defaults to replace invalid values:
```hcl
var.a != "" ? var.a : "default-a"
```

### For Expressions
A `for` expression creates a complex type value by transforming another complex type value. Each element in the input value can correspond to either one or zero values in the result, and an arbitrary expression can be used to transform each input element into an output element.  
For example, if `var.list` were a list of strings, then the following expression would produce a tuple of strings with all-uppercase letters:
```hcl
[for s in var.list : upper(s)]
```

### Splat Expressions
A splat expression provides a more concise way to express a common operation that could otherwise be performed with a `for` expression.  
If `var.list` is a list of objects that all have an attribute `id`, then a list of the ids could be produced with the following `for` expression:
```hcl
[for o in var.list : o.id]
```
This is equivalent to the following splat expression:
```hcl
var.list[*].id
```

### Dynamic Blocks
Within top-level block constructs like resources, expressions can usually be used only when assigning a value to an argument using the `name = expression` form. This covers many uses, but some resource types include repeatable nested blocks in their arguments, which typically represent separate objects that are related to (or embedded within) the containing object:
```hcl
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name = "tf-test-name" # can use expressions here

  setting {
    # but the "setting" block is always a literal block
  }
}
```
You can dynamically construct repeatable nested blocks like `setting` using a special `dynamic` block type, which is supported inside `resource`, `data`, `provider`, and `provisioner` blocks:
```hcl
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = aws_elastic_beanstalk_application.tftest.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.4 running Go 1.12.6"

  dynamic "setting" {
    for_each = var.settings
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}
```

### Built-in Functions
The Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values. The general syntax for function calls is a function name followed by comma-separated arguments in parentheses:
```hcl
max(5, 12, 9)
```
There's a lot of types of functions, like:
- Numeric Functions
- String Functions
- Collection Functions
- Encoding Functions
- Filesystem Functions
- Date and Time Functions
- Hash and Crypto Functions
- IP Network Functions
- Type Conversion Functions
- Terraform-specific Functions