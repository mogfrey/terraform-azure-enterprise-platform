resource "azurerm_user_assigned_identity" "platform" {
  name                = "id-${local.name_prefix}-platform"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.common_tags
}

resource "azurerm_role_assignment" "monitoring_metrics_publisher" {
  scope                = azurerm_log_analytics_workspace.platform.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.platform.principal_id
}

# Add data-plane roles at the narrowest resource scope required by each workload.
# Avoid assigning broad subscription-level Contributor access to application identities.
