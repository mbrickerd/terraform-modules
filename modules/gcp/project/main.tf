/**
 * # Google Cloud Project Module
 *
 * This module establishes a Google Cloud Platform project that serves as the foundational container
 * for all solution resources. The project provides logical isolation, access control, and billing boundaries
 * for your e-commerce data streaming infrastructure.
 *
 * The module creates a fully configured GCP project with:
 * - Consistent naming convention across environments
 * - Optional network creation control
 * - Flexible organization hierarchy placement (org/folder)
 * - Resource labeling and tagging support
 * - Configurable deletion policies
 *
 * Each additional feature (APIs, IAM, audit logs, etc.) can be enabled or disabled independently
 * through the associated module variables.
 */

resource "google_project" "this" {
  name                = "${var.prefix}-${var.name}-${var.environment}"
  project_id          = "${var.prefix}-${var.name}-${var.environment}"
  org_id              = local.project_org_id
  folder_id           = local.project_folder_id
  billing_account     = var.billing_account
  labels              = var.labels
  auto_create_network = var.auto_create_network
  deletion_policy     = var.deletion_policy
  tags                = var.tags
}
