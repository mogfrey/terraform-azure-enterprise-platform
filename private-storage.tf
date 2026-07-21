resource "random_string" "storage_suffix" {
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_storage_account" "platform" {
  name                            = "st${random_string.storage_suffix.result}"
  resource_group_name             = azurerm_resource_group.platform.name
  location                        = azurerm_resource_group.platform.location
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  allow_nested_items_to_be_public = false
  infrastructure_encryption_enabled = true
  tags                            = local.common_tags

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 14
    }

    container_delete_retention_policy {
      days = 14
    }
  }
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "${local.name_prefix}-blob"
  resource_group_name   = azurerm_resource_group.platform.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.platform.id
  registration_enabled  = false
  tags                  = local.common_tags
}

resource "azurerm_private_endpoint" "blob" {
  name                = "pe-${local.name_prefix}-blob"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  subnet_id           = azurerm_subnet.private_endpoints.id
  tags                = local.common_tags

  private_service_connection {
    name                           = "psc-${local.name_prefix}-blob"
    private_connection_resource_id = azurerm_storage_account.platform.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "blob"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }
}
