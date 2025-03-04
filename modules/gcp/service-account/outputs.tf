output "id" {
  value       = google_service_account.service_account.id
  description = "The ID of the service account."
}

output "name" {
  value       = google_service_account.service_account.name
  description = "The fully-qualified name of the service account."
}

output "email" {
  value       = google_service_account.service_account.email
  description = "The email address of the service account."
}

output "unique_id" {
  value       = google_service_account.service_account.unique_id
  description = "The unique ID of the service account."
}
