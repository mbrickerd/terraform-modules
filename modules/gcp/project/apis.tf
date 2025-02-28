/**
 * # Project API Management
 *
 * This file contains resources for managing Google Cloud API services for the project.
 * APIs are only enabled when the `enable_apis` feature flag is set to `true`.
 */

resource "google_project_service" "this" {
  for_each                   = local.services
  project                    = google_project.this.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}

resource "google_project_service_identity" "this" {
  for_each = {
    for i in var.activate_api_identities :
    i.api => i
    if i.api != "compute.googleapis.com"
  }

  provider = google-beta
  project  = google_project.this.project_id
  service  = each.value.api
}

resource "google_project_iam_member" "this" {
  for_each = local.add_service_roles

  project = google_project.this.project_id
  role    = each.value.role
  member  = "serviceAccount:${each.value.email}"
}
