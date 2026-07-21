# Zero-value placeholder. Supply a real value locally or through ARM_SUBSCRIPTION_ID.
subscription_id = "00000000-0000-0000-0000-000000000000"

location       = "westeurope"
project_name   = "cloud-platform"
environment    = "dev"
resource_owner = "platform-engineering@example.com"
department     = "Engineering"

vnet_cidr          = "10.52.0.0/16"
log_retention_days = 30

additional_tags = {
  Cost_Centre         = "CC-DEMO-001"
  Data_Classification = "Internal"
  Business_Service    = "Cloud Platform Lab"
}
