resource "time_sleep" "wait_5_seconds" {
  count           = var.vpc_service_control_attach_enabled || var.vpc_service_control_attach_dry_run ? 1 : 0
  create_duration = var.vpc_service_control_sleep_duration

  depends_on = [
    google_access_context_manager_service_perimeter_resource.service_perimeter_attachment[0],
    google_project_service.this[0]
  ]

}

resource "google_compute_shared_vpc_service_project" "this" {
  provider = google-beta

  count           = var.enable_shared_vpc_service_project ? 1 : 0
  host_project    = var.shared_vpc
  service_project = google_project.this.project_id

  depends_on = [
    time_sleep.wait_5_seconds[0],
    google_project_service.this,
    google_project_service_identity.this,
    google_project_iam_member.this
  ]
}

resource "google_compute_shared_vpc_host_project" "this" {
  provider = google-beta

  count   = var.enable_shared_vpc_host_project ? 1 : 0
  project = google_project.this.project_id

  depends_on = [
    google_project_service.this,
    google_project_service_identity.this,
    google_project_iam_member.this
  ]
}

resource "google_project_default_service_accounts" "this" {
  count          = upper(var.default_service_account) == "KEEP" ? 0 : 1
  action         = upper(var.default_service_account)
  project        = google_project.this.project_id
  restore_policy = "REVERT_AND_IGNORE_FAILURE"

  depends_on = [
    google_project_service.this,
    google_project_service_identity.this,
    google_project_iam_member.this
  ]
}
