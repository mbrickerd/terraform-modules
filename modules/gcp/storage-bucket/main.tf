resource "google_storage_bucket" "bucket" {
  #checkov:skip=CKV_GCP_114:Ensure public access prevention is enforced on Cloud Storage bucket
  name                        = var.name
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = var.force_destroy
  labels                      = var.labels

  dynamic "cors" {
    for_each = var.cors_configuration != null ? [var.cors_configuration] : []
    content {
      origin          = cors.value.origin
      method          = cors.value.method
      response_header = cors.value.response_header
      max_age_seconds = cors.value.max_age_seconds
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class      = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
      }
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
    }
  }

  dynamic "versioning" {
    for_each = var.versioning != null ? [var.versioning] : []
    content {
      enabled = versioning.value
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key != null ? [var.encryption_key] : []
    content {
      default_kms_key_name = encryption.value
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy != null ? [var.retention_policy] : []
    content {
      is_locked        = lookup(retention_policy.value, "is_locked", false)
      retention_period = retention_policy.value.retention_period
    }
  }

  dynamic "logging" {
    for_each = var.logging != null ? [var.logging] : []
    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }
}
