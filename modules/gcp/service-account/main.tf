resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name != null ? var.display_name : var.account_id
  description  = var.description
}

resource "google_project_iam_member" "project_roles" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_service_account_iam_binding" "impersonation" {
  count = var.impersonation_enabled ? 1 : 0

  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = [for sa in var.impersonation_service_accounts : "serviceAccount:${sa}"]
}
