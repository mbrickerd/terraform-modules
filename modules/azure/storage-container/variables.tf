variable "name" {
  description = "The name of the Container which should be created within the Storage Account."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account where the Container should be created."
  type        = string
}

variable "container_access_type" {
  description = "The Access Level configured for this Container. Defaults to `private`."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["blob", "container", "private"], var.container_access_type)
    error_message = "Invalid value for container_access_type. Must be one of: `blob`, `container`, `private`."
  }
}

variable "default_encryption_scope" {
  description = "The default encryption scope to use for blobs uploaded to this container."
  type        = string
  default     = null
}

variable "encryption_scope_override_enabled" {
  description = "Whether to allow blobs to override the default encryption scope for this container. Can only be set when specifying `default_encryption_scope`. Defaults to `true`."
  type        = bool
  default     = true

  validation {
    condition     = var.default_encryption_scope != null || var.encryption_scope_override_enabled == true
    error_message = "When default_encryption_scope is not specified, encryption_scope_override_enabled must be true."
  }
}

variable "metadata" {
  description = "A mapping of MetaData for this Container. All metadata keys should be lowercase."
  type        = map(string)
  default     = null

  validation {
    condition = var.metadata == null || alltrue([
      for k, v in var.metadata : lower(k) == k
    ])
    error_message = "All metadata keys must be lowercase."
  }
}
