# Process the compute.googleapis.com identity separately, if present in the inputs.
data "google_compute_default_service_account" "default" {
  count   = local.activate_compute_identity ? 1 : 0
  project = google_project.this.project_id
}
