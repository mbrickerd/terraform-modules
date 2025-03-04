variable "dataset_id" {
  type        = string
  description = "The ID of the BigQuery dataset."
}

variable "location" {
  type        = string
  description = "The location of the BigQuery dataset."
}

variable "allow_deletion" {
  type        = bool
  default     = false
  description = "Whether to allow deletion of the BigQuery dataset when tables are present."
}

variable "project" {
  type        = string
  default     = null
  description = "Project where the BigQuery resources are being created."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels to apply to all applicable resources in this module."
}
