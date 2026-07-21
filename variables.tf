variable "subscription_id" {
  description = "Target Azure subscription ID. Use a local value or ARM_SUBSCRIPTION_ID and never commit a real identifier publicly."
  type        = string
}

variable "location" {
  description = "Azure region for platform resources."
  type        = string
  default     = "westeurope"
}

variable "project_name" {
  description = "Short project name used in resource names and tags."
  type        = string
  default     = "cloud-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "uat", "prod"], var.environment)
    error_message = "Environment must be dev, test, uat or prod."
  }
}

variable "resource_owner" {
  description = "Accountable owner recorded on all resources."
  type        = string
}

variable "department" {
  description = "Owning department or cost-allocation unit."
  type        = string
}

variable "vnet_cidr" {
  description = "Synthetic or approved address space for the platform VNet."
  type        = string
  default     = "10.52.0.0/16"
}

variable "log_retention_days" {
  description = "Log Analytics retention period."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 30
    error_message = "Log retention must be at least 30 days."
  }
}

variable "additional_tags" {
  description = "Additional organization-specific tags."
  type        = map(string)
  default     = {}
}
