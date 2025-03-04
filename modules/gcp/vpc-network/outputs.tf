output "id" {
  value       = google_compute_network.default.id
  description = "The unique identifier for the network."
}

output "name" {
  value       = google_compute_network.default.name
  description = "The name of the network."
}

output "gateway_ipv4" {
  value       = google_compute_network.default.gateway_ipv4
  description = "The gateway address for default routing out of the network."
}

output "self_link" {
  value       = google_compute_network.default.self_link
  description = "The URI of the created network."
}
