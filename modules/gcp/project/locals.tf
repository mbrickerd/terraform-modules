locals {
  project        = "${var.prefix}-${var.name}-${var.environment}"
  origin         = "terraform-managed-lien"
  default_labels = {}

  default_enabled_apis = [
    "networkmanagement.googleapis.com",
    "privilegedaccessmanager.googleapis.com",
    "servicehealth.googleapis.com"
  ]
}
