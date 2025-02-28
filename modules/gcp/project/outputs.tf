output "id" {
  value       = google_project.this.id
  description = "An identifier for the project resource with format `projects/{{project}}`."
}

output "number" {
  value       = google_project.this.number
  description = "The numeric identifier of the project."
}

output "enabled_apis" {
  value       = [for api in google_project_service.this : api.service]
  description = "The list of enabled APIs in the project."
}

output "enabled_api_identities" {
  value       = { for i in google_project_service_identity.this : i.service => i.email }
  description = "The mapping of enabled API identities in the project."
}
