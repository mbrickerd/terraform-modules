variable "project_id" {
  type        = string
  description = "The ID of the project where the bucket will be created."
}

variable "name" {
  type        = string
  description = "The name of the bucket."
}

variable "location" {
  type        = string
  default     = "europe-west4"
  description = "The location of the bucket."
}

variable "storage_class" {
  type        = string
  description = "The storage class of the bucket."
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Invalid value for storage_class. Must be one of: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
  description = "Enables uniform bucket-level access on a bucket. Defaults to `true`."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When deleting a bucket, this boolean option will delete all contained objects."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the bucket."
}

variable "versioning" {
  type        = bool
  default     = null
  description = "Whether to enable versioning for this bucket."
}

variable "lifecycle_rules" {
  type = list(object({
    condition = object({
      age                        = optional(number)
      created_before             = optional(string)
      with_state                 = optional(string)
      matches_storage_class      = optional(list(string))
      num_newer_versions         = optional(number)
      days_since_noncurrent_time = optional(number)
    })
    action = object({
      type          = string
      storage_class = optional(string)
    })
  }))
  default     = []
  description = "A list of lifecycle rules to configure."
}

variable "cors_configuration" {
  type = object({
    origin          = list(string)
    method          = list(string)
    response_header = list(string)
    max_age_seconds = number
  })
  default     = null
  description = "The CORS configuration for the bucket."
}

variable "encryption_key" {
  type        = string
  default     = null
  description = "The Customer-Managed Encryption Key used to encrypt the bucket."
}

variable "retention_policy" {
  type = object({
    is_locked        = optional(bool, false)
    retention_period = number
  })
  default     = null
  description = "The configuration of the bucket's retention policy."
}

variable "logging" {
  type = object({
    log_bucket        = string
    log_object_prefix = optional(string)
  })
  default     = null
  description = "The bucket's Access & Storage Logs configuration."
}
