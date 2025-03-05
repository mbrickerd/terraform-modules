variable "project_id" {
  type        = string
  description = "The ID of the project where the repository will be created."
}

variable "repository_id" {
  type        = string
  description = "The ID of the repository."
}

variable "location" {
  type        = string
  description = "The location of the repository."
}

variable "format" {
  type        = string
  description = "The format of the repository."

  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "KFP", "UNSPECIFIED"], var.format)
    error_message = "Invalid format for format. Must be one of: `DOCKER`, `MAVEN`, `NPM`, `PYTHON`, `APT`, `YUM`, `KFP`, `UNSPECIFIED`."
  }
}

variable "mode" {
  type        = string
  default     = "STANDARD_REPOSITORY"
  description = "The mode of the repository. Defaults to `STANDARD_REPOSITORY`."

  validation {
    condition     = contains(["STANDARD_REPOSITORY", "VIRTUAL_REPOSITORY", "REMOTE_REPOSITORY"], var.mode)
    error_message = "Invalid value for mode. Must be one of: `STANDARD_REPOSITORY`, `VIRTUAL_REPOSITORY`, `REMOTE_REPOSITORY`."
  }
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the repository."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "The label mapping to be applied to the repository."
}

# Security settings
variable "kms_key_name" {
  type        = string
  default     = null
  description = "The name of the Cloud KMS key to use for repository encryption. Defaults to `null`."
}

# Format-specific configurations
variable "docker_config" {
  type = object({
    immutable_tags = bool
  })
  default     = null
  description = "Docker repository configuration. Defaults to `null`."
}

variable "maven_config" {
  type = object({
    allow_snapshot_overwrites = bool
    version_policy            = string
  })
  default     = null
  description = "Maven repository configuration. Defaults to `null`."
}

# Virtual repository configuration
variable "virtual_repository_config" {
  type = object({
    upstream_policies = list(object({
      id         = string
      repository = string
      priority   = number
    }))
  })
  default     = null
  description = "Virtual repository configuration (if mode = VIRTUAL_REPOSITORY). Defaults to `null`."
}

# Remote repository configuration
variable "remote_repository_config" {
  type        = any
  default     = null
  description = "Remote repository configuration (if mode = REMOTE_REPOSITORY). Defaults to `null`."
}

# Cleanup policies
variable "cleanup_policy_dry_run" {
  type        = bool
  default     = true
  description = "Whether to cleanup policies run in dry run mode. Defaults to `true`."
}

variable "cleanup_policies" {
  type        = any
  default     = {}
  description = "Repository cleanup policies."
}

# IAM settings
variable "iam_members" {
  type = object({
    readers = optional(list(string), [])
    writers = optional(list(string), [])
    admins  = optional(list(string), [])
  })
  default     = {}
  description = "IAM members to grant access to the repository."
}
