resource "google_compute_subnetwork" "default" {
  name                       = var.name
  description                = var.description
  network                    = var.network
  region                     = var.region
  role                       = var.role
  purpose                    = var.purpose
  project                    = var.project
  ip_cidr_range              = var.ip_cidr_range
  private_ip_google_access   = var.private_ip_google_access
  private_ipv6_google_access = var.private_ipv6_google_access

  dynamic "log_config" {
    for_each = var.disable_logging ? [] : [1]
    content {
      aggregation_interval = "INTERVAL_5_SEC"
      flow_sampling        = 1
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges != null ? var.secondary_ip_ranges : []

    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
