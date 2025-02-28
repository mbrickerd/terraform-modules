/**
 * # Google Cloud Audit Logging Configuration
 *
 * This module configures comprehensive audit logging for the GCP project.
 * It enables Data Access, Admin Activity, and System Event audit logs
 * to ensure proper monitoring, compliance, and security oversight of all
 * actions taken within the project environment.
 */

resource "google_project_iam_audit_config" "project_audit_config" {
  count   = var.enable_audit_logs ? 1 : 0
  project = google_project.this.project_id
  service = "allServices"

  # Admin activity logs - always enabled and cannot be disabled
  audit_log_config {
    log_type = "ADMIN_READ"
  }

  # Data access logs - detects when data is accessed
  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

# Ensures that logs are stored for an appropriate retention period
resource "google_logging_project_sink" "audit_log_sink" {
  count = var.enable_audit_logs && var.create_audit_logs_storage ? 1 : 0

  name        = "${var.prefix}-${var.name}-${var.environment}-audit-logs"
  project     = google_project.this.project_id
  destination = "storage.googleapis.com/${module.audit_logs_bucket[0].name}"

  # Filter to include all audit logs
  filter = "logName:\"cloudaudit.googleapis.com\""

  # Use a unique writer identity
  unique_writer_identity = true
}

# Use the storage-bucket module to create the audit logs bucket
module "audit_logs_bucket" {
  count  = var.enable_audit_logs && var.create_audit_logs_storage ? 1 : 0
  source = "../storage-bucket" # Adjust path as needed

  create_bucket               = true
  name                        = "${var.prefix}-${var.name}-${var.environment}-audit-logs"
  project_id                  = google_project.this.project_id
  location                    = var.audit_logs_location
  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  # Self-logging for audit logs bucket
  logging = var.audit_logs_self_logging ? {
    log_bucket        = "${var.prefix}-${var.name}-${var.environment}-audit-logs"
    log_object_prefix = "self-logs"
  } : null

  retention_policy = {
    is_locked        = true
    retention_period = var.audit_logs_retention_period
  }

  lifecycle_rules = [{
    condition = {
      age = var.audit_logs_lifecycle_age
    }
    action = {
      type = "Delete"
    }
  }]
}

# Grant the log sink service account permission to write to the bucket
resource "google_storage_bucket_iam_member" "audit_log_writer" {
  count = var.enable_audit_logs && var.create_audit_logs_storage ? 1 : 0

  bucket = module.audit_logs_bucket[0].name
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.audit_log_sink[0].writer_identity
}
