resource "azurerm_storage_container" "this" {
  #checkov:skip=CKV2_AZURE_21:Ensure Storage logging is enabled for Blob service for read requests
  name                              = var.name
  storage_account_id                = var.storage_account_id
  container_access_type             = var.container_access_type
  default_encryption_scope          = var.default_encryption_scope
  metadata                          = var.metadata
  encryption_scope_override_enabled = local.encryption_scope_override_enabled
}
