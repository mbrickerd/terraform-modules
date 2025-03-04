resource "google_dataflow_job" "job" {
  name              = var.name
  project           = var.project_id
  region            = var.region
  template_gcs_path = var.template_gcs_path
  temp_gcs_location = var.temp_gcs_location

  machine_type           = var.machine_type
  max_workers            = var.max_workers
  network                = var.network
  subnetwork             = var.subnetwork
  service_account_email  = var.service_account_email
  kms_key_name           = var.kms_key_name
  on_delete              = var.on_delete
  labels                 = var.labels
  parameters             = var.parameters
  additional_experiments = var.additional_experiments

  # Instead of dynamic block, use conditional to set ip_configuration directly
  ip_configuration = var.ip_configuration

  # Instead of dynamic block for transform_name_mapping, use the values directly
  # Note: If this is supposed to be a map of transform names, we need to verify how the API expects it
  transform_name_mapping = var.transform_name_mapping != {} ? var.transform_name_mapping : null

  depends_on = [var.dependencies]
}
