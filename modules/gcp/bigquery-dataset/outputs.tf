output "id" {
  value       = google_bigquery_dataset.default.dataset_id
  description = "An identifier for the resource with format `projects/{{project}}/datasets/{{dataset_id}}`"
}
