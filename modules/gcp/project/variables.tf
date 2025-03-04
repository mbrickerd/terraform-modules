variable "prefix" {
  type        = string
  description = "The prefix name that will be used in the Google project naming convention."
}

variable "name" {
  type        = string
  description = "The base name that will be used in the Google project naming convention."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Specifies the environment the Google project belongs to."

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "org_id" {
  type        = number
  default     = null
  description = "The numeric ID of the organization this project belongs to."
}

variable "folder_id" {
  type        = string
  default     = null
  description = "The ID of the folder where this project will be created."
}

variable "billing_account" {
  type        = string
  description = "The alphanumeric ID of the billing account this project belongs to."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the project. Note: This field is non-authoritative, and will only manage the labels present in your configuration."
}

variable "auto_create_network" {
  type        = bool
  default     = false
  description = "Controls whether the 'default' network exists on the project. Defaults to `false`."
}

variable "deletion_policy" {
  type        = string
  default     = "PREVENT"
  description = "The deletion policy for the Project. Setting PREVENT will protect the project against any destroy actions caused by a `terraform apply` or `terraform destroy`."

  validation {
    condition     = contains(["PREVENT", "ABANDON", "DELETE"], var.deletion_policy)
    error_message = "Invalid value for deletion_policy. Must be one of: PREVENT, ABANDON, DELETE."
  }
}

variable "deletion_prevention" {
  type = object({
    reasons     = list(string)
    skip_delete = optional(bool),
  })
  default = {
    reasons     = []
    skip_delete = true
  }
  description = "Block that covers various properties around project liens."
}

variable "google_apis" {
  type        = list(string)
  default     = []
  description = "A list of Google services to enable in the project."
}
