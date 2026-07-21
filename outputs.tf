output "resource_group_name" {
  description = "Platform resource group name."
  value       = azurerm_resource_group.platform.name
}

output "virtual_network_id" {
  description = "Platform virtual network resource ID."
  value       = azurerm_virtual_network.platform.id
}

output "subnet_ids" {
  description = "Subnet resource IDs by platform tier."
  value = {
    platform         = azurerm_subnet.platform.id
    data             = azurerm_subnet.data.id
    private_endpoints = azurerm_subnet.private_endpoints.id
    management       = azurerm_subnet.management.id
  }
}

output "managed_identity_client_id" {
  description = "Client ID of the user-assigned platform identity."
  value       = azurerm_user_assigned_identity.platform.client_id
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID."
  value       = azurerm_log_analytics_workspace.platform.id
}

output "storage_account_name" {
  description = "Generated private storage account name."
  value       = azurerm_storage_account.platform.name
}

output "blob_private_endpoint_ip" {
  description = "Private IP assigned to the Blob Storage private endpoint."
  value       = azurerm_private_endpoint.blob.private_service_connection[0].private_ip_address
}
