resource "azurerm_resource_group" "default" {
  name       = local.resource_group_name
  location   = var.location
  managed_by = var.managed_by
  tags       = merge(var.tags, { environment = var.environment })
}
