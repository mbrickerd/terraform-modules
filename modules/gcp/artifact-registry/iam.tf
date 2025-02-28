resource "google_artifact_registry_repository_iam_member" "readers" {
  for_each = toset(var.iam_members.readers)

  project    = google_artifact_registry_repository.repository.project
  location   = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name

  role   = "roles/artifactregistry.reader"
  member = each.value

  depends_on = [
    google_artifact_registry_repository.repository
  ]
}

# IAM for repository writers
resource "google_artifact_registry_repository_iam_member" "writers" {
  for_each = toset(var.iam_members.writers)

  project    = google_artifact_registry_repository.repository.project
  location   = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name

  role   = "roles/artifactregistry.writer"
  member = each.value

  depends_on = [
    google_artifact_registry_repository.repository
  ]
}

# IAM for repository administrators
resource "google_artifact_registry_repository_iam_member" "admins" {
  for_each = toset(var.iam_members.admins)

  project    = google_artifact_registry_repository.repository.project
  location   = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name

  role   = "roles/artifactregistry.admin"
  member = each.value

  depends_on = [
    google_artifact_registry_repository.repository
  ]
}
