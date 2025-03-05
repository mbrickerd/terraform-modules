output "bucket" {
  value       = google_storage_bucket.bucket
  description = "The created storage bucket resource."
}

output "name" {
  value       = google_storage_bucket.bucket.name
  description = "The name of the bucket."
}

output "url" {
  value       = "gs://${google_storage_bucket.bucket.name}"
  description = "The base URL of the bucket, in the format `gs://<bucket-name>`."
}

output "self_link" {
  value       = google_storage_bucket.bucket.self_link
  description = "The URI of the created bucket."
}
