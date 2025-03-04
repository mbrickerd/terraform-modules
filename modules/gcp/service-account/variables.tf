variable "project_id" {
  type        = string
  description = "The project ID where the service account will be created."
}

variable "account_id" {
  type        = string
  description = "The account ID for the service account."
}

variable "display_name" {
  type        = string
  default     = null
  description = "The display name for the service account."
}

variable "description" {
  type        = string
  default     = null
  description = "A description of the service account."
}

variable "roles" {
  type        = list(string)
  default     = []
  description = "The IAM roles to assign to the service account in the project."
}

variable "impersonation_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable the service account impersonation feature."
}

variable "impersonation_service_accounts" {
  type        = list(string)
  default     = []
  description = "A list of service accounts that can impersonate this service account."
}
