locals {
  provider_version = "2.92.0"
}

# Inject the remote backend configuration in all the modules that includes the root file without having to define them in the underlying modules 
remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  # Store the terraform state files in a blob container located on an azure storage account
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = "rg-terragrunt-backend-state"
    storage_account_name = "stterragruntstate"
    container_name       = "terragrunt"
  }
}

# Inject this provider configuration in all the modules that includes the root file without having to define them in the underlying modules
# This instructs Terragrunt to create the file provider.tf in the working directory (where Terragrunt calls terraform) before it calls any 
# of the Terraform commands (e.g plan, apply, validate, etc)
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  version = "=${local.provider_version}"
  features {}
  skip_provider_registration = true
  subscription_id      = "872fa591-73f6-48e4-a857-8c155101cd34"
}
EOF
}
