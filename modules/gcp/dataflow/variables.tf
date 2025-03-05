variable "project_id" {
  type        = string
  description = "The project ID where the Dataflow job will be created."
}

variable "name" {
  type        = string
  description = "The name of the Dataflow job."
}

variable "region" {
  type        = string
  default     = "europe-west4"
  description = "The region where the Dataflow job will run. Defaults to `europe-west4`."
}

variable "template_gcs_path" {
  type        = string
  description = "The GCS path to the Dataflow job template."
}

variable "temp_gcs_location" {
  type        = string
  description = "The GCS location for temporary files during job execution."
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-2"
  description = "The machine type to use for the job. Defaults to `n1-standard-2`."
}

variable "max_workers" {
  type        = number
  default     = 2
  description = "The maximum number of workers permitted for the job. Defaults to 2."
}

variable "network" {
  type        = string
  default     = null
  description = "The network to which VMs will be assigned."
}

variable "subnetwork" {
  type        = string
  default     = null
  description = "The subnetwork to which VMs will be assigned."
}

variable "service_account_email" {
  type        = string
  default     = null
  description = "The service account email to run the job as."
}

variable "kms_key_name" {
  type        = string
  default     = null
  description = "The name for the Cloud KMS key to protect the job."
}

variable "on_delete" {
  type        = string
  default     = "drain"
  description = "Specifies behavior of deletion during `terraform destroy`. Possible values are 'drain' or 'cancel'. "

  validation {
    condition     = contains(["drain", "cancel"], var.on_delete)
    error_message = "Invalid value for on_delete. Must be one of: `drain`, `cancel`."
  }
}

variable "parameters" {
  type        = map(string)
  default     = {}
  description = "A set of key/value pairs to be passed to the Dataflow job."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "User labels to be specified for the job."
}

variable "additional_experiments" {
  type        = list(string)
  default     = null
  description = "A list of experiments to enable for the job."
}

variable "ip_configuration" {
  type        = string
  default     = null
  description = "The configuration for VM IPs. Possible values are are 'WORKER_IP_PUBLIC' or 'WORKER_IP_PRIVATE'."

  validation {
    condition     = var.ip_configuration == null || contains(["WORKER_IP_PUBLIC", "WORKER_IP_PRIVATE"], var.ip_configuration)
    error_message = "Invalid value for ip_configuration. Must be one of: WORKER_IP_PUBLIC, WORKER_IP_PRIVATE."
  }
}

variable "transform_name_mapping" {
  type        = map(string)
  default     = {}
  description = "Only applicable when updating a pipeline. Map of transform name replacements."
}

variable "dependencies" {
  type        = list(any)
  default     = []
  description = "A list of resources the Dataflow job depends on."
}
