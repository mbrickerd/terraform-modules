resource "google_bigquery_dataset" "default" {
  # checkov:skip=CKV_GCP_81:Ensure Big Query Tables are encrypted with Customer Supplied Encryption Keys (CSEK)
  dataset_id                 = var.dataset_id
  location                   = var.location
  project                    = var.project
  labels                     = var.labels
  delete_contents_on_destroy = var.allow_deletion
}
