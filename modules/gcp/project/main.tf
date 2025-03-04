resource "google_project" "default" {
  #checkov:skip=CKV2_GCP_5:Ensure that Cloud Audit Logging is configured properly across all services and all users from a project
  name                = local.project
  project_id          = local.project
  org_id              = var.org_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = var.auto_create_network
  labels              = merge(local.default_labels, var.labels)
  deletion_policy     = var.deletion_policy
}

resource "google_resource_manager_lien" "default" {
  for_each = toset(var.deletion_prevention.reasons)

  restrictions = ["resourcemanager.projects.delete"]
  origin       = local.origin
  reason       = each.value
  parent       = google_project.default.id
}

resource "google_project_service" "default" {
  for_each = toset(setunion(local.default_enabled_apis, var.google_apis))

  service            = each.value
  disable_on_destroy = false
  project            = google_project.default.project_id
}
