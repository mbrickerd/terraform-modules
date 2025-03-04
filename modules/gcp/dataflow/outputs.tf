output "id" {
  value       = google_dataflow_job.job.id
  description = "The Dataflow job ID."
}

output "state" {
  value       = google_dataflow_job.job.state
  description = "The current state of the Dataflow job."
}

output "name" {
  value       = google_dataflow_job.job.name
  description = "The name of the Dataflow job."
}
