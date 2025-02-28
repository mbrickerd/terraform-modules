/**
 * # Google Cloud Storage Bucket Module
 *
 * This module creates a Google Cloud Storage bucket with configurable settings
 * and IAM permissions. It provides a standardized approach to bucket creation
 * with security best practices and flexible access controls.
 */

resource "google_storage_bucket" "bucket" {
  provider = google-beta

  count = var.create_bucket ? 1 : 0

  name                        = var.name
  project                     = var.project_id
  location                    = var.location
  labels                      = var.labels
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention

  dynamic "versioning" {
    for_each = var.versioning_enabled ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "logging" {
    for_each = var.logging != null ? [var.logging] : []
    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy != null ? [var.retention_policy] : []
    content {
      is_locked        = retention_policy.value.is_locked
      retention_period = retention_policy.value.retention_period
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }

      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
    }
  }
}

# IAM permissions for group
resource "google_storage_bucket_iam_member" "group_iam" {
  for_each = var.create_bucket && var.group_id != "" ? var.group_iam_roles : toset([])

  bucket = google_storage_bucket.bucket[0].name
  role   = each.value
  member = "group:${var.group_id}"
}

# IAM permissions for service account
resource "google_storage_bucket_iam_member" "service_account_iam" {
  for_each = var.create_bucket && var.service_account_id != "" ? var.service_account_iam_roles : toset([])

  bucket = google_storage_bucket.bucket[0].name
  role   = each.value
  member = "serviceAccount:${var.service_account_id}"
}

# IAM permissions for Google APIs service account
resource "google_storage_bucket_iam_member" "api_service_account_iam" {
  for_each = var.create_bucket && var.api_service_account_id != "" ? var.api_service_account_iam_roles : toset([])

  bucket = google_storage_bucket.bucket[0].name
  role   = each.value
  member = "serviceAccount:${var.api_service_account_id}"
}
