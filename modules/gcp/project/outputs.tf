output "id" {
  value       = google_project.default.id
  description = "An identifier for the project resource with format `projects/{{project}}`."
}

output "number" {
  value       = google_project.default.number
  description = "The numeric identifier of the project."
}
