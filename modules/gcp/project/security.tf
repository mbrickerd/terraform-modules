/******************************************
  Attachment to VPC Service Control Perimeter in Enforce Mode
 *****************************************/
resource "google_access_context_manager_service_perimeter_resource" "service_perimeter_attachment" {
  count          = var.vpc_service_control_attach_enabled ? 1 : 0
  depends_on     = [google_service_account.default_service_account]
  perimeter_name = var.vpc_service_control_perimeter_name
  resource       = "projects/${google_project.this.number}"
}

/******************************************
  Attachment to VPC Service Control Perimeter in Dry Run Mode
 *****************************************/
resource "google_access_context_manager_service_perimeter_dry_run_resource" "service_perimeter_attachment_dry_run" {
  count          = var.vpc_service_control_attach_dry_run && !var.vpc_service_control_attach_enabled ? 1 : 0
  depends_on     = [google_service_account.default_service_account]
  perimeter_name = var.vpc_service_control_perimeter_name
  resource       = "projects/${google_project.this.number}"
}

/******************************************
  Enable Access Context Manager API
 *****************************************/
resource "google_project_service" "enable_access_context_manager" {
  count   = var.vpc_service_control_attach_enabled || var.vpc_service_control_attach_dry_run ? 1 : 0
  project = google_project.this.number
  service = "accesscontextmanager.googleapis.com"
}

/******************************************
  Configure default Network Service Tier
 *****************************************/
resource "google_compute_project_default_network_tier" "default" {
  count        = var.default_network_tier != "" ? 1 : 0
  project      = google_project.this.number
  network_tier = var.default_network_tier
}

resource "google_tags_tag_binding" "bindings" {
  for_each  = toset(var.tag_binding_values)
  parent    = "//cloudresourcemanager.googleapis.com/projects/${google_project.this.number}"
  tag_value = "tagValues/${each.value}"
}
