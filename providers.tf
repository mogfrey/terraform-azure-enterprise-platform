terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0, < 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6, < 4.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    {
      Project        = var.project_name
      Environment    = var.environment
      Resource_Owner = var.resource_owner
      Department     = var.department
      Managed_By     = "Terraform"
      Repository     = "terraform-azure-enterprise-platform"
    },
    var.additional_tags
  )
}
