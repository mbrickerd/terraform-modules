output "bucket" {
  value       = var.create_bucket ? google_storage_bucket.bucket[0] : null
  description = "The created storage bucket."
}

output "name" {
  value       = var.create_bucket ? google_storage_bucket.bucket[0].name : null
  description = "The name of the bucket."
}

output "url" {
  value       = var.create_bucket ? google_storage_bucket.bucket[0].url : null
  description = "The base URL of the bucket."
}

output "self_link" {
  value       = var.create_bucket ? google_storage_bucket.bucket[0].self_link : null
  description = "The URI of the bucket."
}
