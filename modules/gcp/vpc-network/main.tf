data "google_netblock_ip_ranges" "this" {
  for_each = toset([
    "health-checkers",
    "legacy-health-checkers",
  ])
  range_type = each.key
}

resource "google_compute_network" "default" {
  name                            = var.name
  description                     = var.description
  project                         = var.project
  mtu                             = var.mtu
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = true
}

# Deny all ingress traffic
resource "google_compute_firewall" "deny_all_ingress" {
  count = var.deny_all_ingress ? 1 : 0

  network       = google_compute_network.default.id
  name          = "${var.name}-deny-all-ingress"
  description   = "Default deny for ingress traffic"
  priority      = 65534
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  deny {
    protocol = "all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  project = var.project
}

# Deny all egress traffic
resource "google_compute_firewall" "deny_all_egress" {
  count = var.deny_all_egress ? 1 : 0

  network     = google_compute_network.default.id
  name        = "${var.name}-deny-all-egress"
  description = "Default deny for egress traffic"
  priority    = 65534
  direction   = "EGRESS"

  deny {
    protocol = "all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  project = var.project
}

# Route public internet traffic to the default internet gateway
resource "google_compute_route" "public_internet" {
  count            = var.create_quadzero_route ? 1 : 0
  project          = var.project
  network          = google_compute_network.default.id
  name             = "${var.name}-public-internet"
  description      = "Custom static route to communicate with the public internet"
  dest_range       = local.quadzero_cidr
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

# Allow private google access egress traffic
resource "google_compute_firewall" "enable_private_google_connectivity" {
  count = var.enable_private_google_connectivity ? 1 : 0

  network     = google_compute_network.default.id
  name        = "${var.name}-private-google-access"
  description = "Allow private google access for all instances"
  priority    = 4000
  direction   = "EGRESS"
  target_tags = []

  destination_ranges = [
    local.vpc_private_google_access_cidr,
    local.vpc_restricted_google_access_cidr,
  ]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  project = var.project
}

# Route private google access traffic to the default internet gateway
resource "google_compute_route" "private_google_access" {
  count = var.enable_private_google_connectivity ? 1 : 0

  project          = var.project
  network          = google_compute_network.default.id
  name             = "${var.name}-private-google-access"
  description      = "Custom static route to communicate with Google APIs using private.googleapis.com"
  dest_range       = local.vpc_private_google_access_cidr
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

# Route restricted google access traffic to the default internet gateway
resource "google_compute_route" "restricted_google_access" {
  count = var.enable_private_google_connectivity ? 1 : 0

  project          = var.project
  network          = google_compute_network.default.id
  name             = "${var.name}-restricted-google-access"
  description      = "Custom static route to communicate with Google APIs using restricted.googleapis.com"
  dest_range       = local.vpc_restricted_google_access_cidr
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

# Allow TCP forwarded IAP ingress traffic
resource "google_compute_firewall" "allow_iap_ingress" {
  count = var.allow_iap_ingress ? 1 : 0

  network       = google_compute_network.default.id
  name          = "${var.name}-iap-access"
  description   = "Allow ingress traffic from a IP range containing all the IP addresses used by IAP for TCP forwarding"
  priority      = 1000
  direction     = "INGRESS"
  source_ranges = [local.vpc_iap_tcp_forwarding_cidr]
  project       = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Allow Google Cloud to issue Load Balancer health checks
resource "google_compute_firewall" "lb_health_check" {
  count = var.allow_loadbalancer_health_checks ? 1 : 0

  name        = "${var.name}-lb-health-checks"
  description = "Allow inbound Google Load Balancer health checks"
  priority    = 1000
  direction   = "INGRESS"
  network     = google_compute_network.default.id
  allow {
    protocol = "tcp"
  }
  # These are the source IP ranges for health checks (managed by Google Cloud)
  source_ranges = distinct(concat(
    data.google_netblock_ip_ranges.this["health-checkers"].cidr_blocks_ipv4,
    data.google_netblock_ip_ranges.this["legacy-health-checkers"].cidr_blocks_ipv4,
  ))
  project = var.project
}

resource "google_dns_managed_zone" "zones" {
  for_each   = { for k, v in local.dns_zones : k => v if var.enable_private_google_connectivity }
  name       = each.key
  dns_name   = each.value.dns
  visibility = "private"

  private_visibility_config {

    dynamic "networks" {
      for_each = [google_compute_network.default.id]

      content {
        network_url = google_compute_network.default.id
      }
    }
  }
  labels  = var.labels
  project = var.project
}

resource "google_dns_record_set" "a_records" {
  for_each = { for k, v in google_dns_managed_zone.zones : k => v if var.enable_private_google_connectivity }

  name         = each.value.dns_name
  managed_zone = each.value.name
  type         = "A"
  ttl          = 300
  rrdatas      = local.dns_zones[each.key].ips
  project      = var.project
}

resource "google_dns_record_set" "cname_records" {
  for_each = { for k, v in google_dns_managed_zone.zones : k => v if var.enable_private_google_connectivity }

  name         = "*.${each.value.dns_name}"
  managed_zone = each.value.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [each.value.dns_name]
  project      = var.project
}
