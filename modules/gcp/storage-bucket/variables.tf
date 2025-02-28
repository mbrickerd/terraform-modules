variable "create_bucket" {
  type        = bool
  default     = true
  description = "Whether to create a storage bucket. Defaults to `true`."
}

variable "name" {
  type        = string
  description = "The name of the bucket."
}

variable "project_id" {
  type        = string
  description = "The ID of the project to create the bucket in."
}

variable "location" {
  type        = string
  default     = "US"
  description = "The location of the bucket."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A mapping of labels to assign to the bucket."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When deleting a bucket, this boolean option will delete all contained objects. Defaults to `false`."
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
  description = "Whether to enable Uniform bucket-level access. Defaults to `true`."
}

variable "public_access_prevention" {
  type        = string
  default     = "enforced"
  description = "Prevents public access to a bucket. Defaults to `enforced`."

  validation {
    condition     = contains(["inherited", "enforced"], var.public_access_prevention)
    error_message = "Insufficient value for public_access_prevention. Must be one of: `inherited`, `enforced`."
  }
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable versioning for the bucket."
}

variable "retention_policy" {
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default     = null
  description = "Configuration of the bucket's data retention policy. Default is `null`."
}

variable "lifecycle_rules" {
  type = list(object({
    condition = object({
      age                   = optional(number)
      created_before        = optional(string)
      with_state            = optional(string)
      matches_storage_class = optional(list(string))
      num_newer_versions    = optional(number)
    })
    action = object({
      type          = string
      storage_class = optional(string)
    })
  }))
  default     = []
  description = "List of lifecycle rules to configure."
}

variable "logging" {
  type = object({
    log_bucket        = string
    log_object_prefix = optional(string)
  })
  default     = null
  description = "The bucket's Access & Storage Logs configuration."
}

variable "group_id" {
  type        = string
  default     = ""
  description = "The ID of the Google group to grant permissions to."
}

variable "group_iam_roles" {
  type        = set(string)
  default     = ["roles/storage.admin"]
  description = "IAM roles to be granted to the Google group on the bucket."
}

variable "service_account_id" {
  type        = string
  default     = ""
  description = "The ID of the service account to grant permissions to."
}

variable "service_account_iam_roles" {
  type        = set(string)
  default     = ["roles/storage.admin"]
  description = "IAM roles to be granted to the service account on the bucket."
}

variable "api_service_account_id" {
  type        = string
  default     = ""
  description = "The ID of the Google APIs service account to grant permissions to."
}

variable "api_service_account_iam_roles" {
  type        = set(string)
  default     = ["roles/storage.admin"]
  description = "IAM roles to be granted to the Google APIs service account on the bucket."
}
