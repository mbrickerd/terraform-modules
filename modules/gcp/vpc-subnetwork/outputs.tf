output "id" {
  value       = google_compute_subnetwork.default.id
  description = "Identifier for the subnetwork"
}

output "name" {
  value       = google_compute_subnetwork.default.name
  description = "Name of the subnetwork"
}

output "ip_cidr_range" {
  value       = google_compute_subnetwork.default.ip_cidr_range
  description = "IP CIDR range for the subnetwork"
}

output "region" {
  value       = google_compute_subnetwork.default.region
  description = "Region where the subnetwork is created in"
}

output "creation_timestamp" {
  value       = google_compute_subnetwork.default.creation_timestamp
  description = "Creation timestamp in RFC3339 text format"
}

output "gateway_address" {
  value       = google_compute_subnetwork.default.gateway_address
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork"
}

output "self_link" {
  value       = google_compute_subnetwork.default.self_link
  description = "The URI of the created resource"
}
