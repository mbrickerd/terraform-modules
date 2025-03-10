locals {
  encryption_scope_override_enabled = var.default_encryption_scope != null ? var.encryption_scope_override_enabled : null
}
