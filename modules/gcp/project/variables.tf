variable "prefix" {
  type        = string
  description = ""
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
    error_message = "Invalid value for deletion_policy. Must be one of: PREVENT, ABANDON, DELETE"
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of resource manager tags."
}

variable "lien" {
  type        = bool
  default     = false
  description = "Whether to add a lien on the project to prevent accidental deletion. Defaults to `false`."
}

variable "enable_apis" {
  description = "Whether to actually enable the APIs. If false, this module is a no-op."
  type        = bool
  default     = true
}

variable "activate_apis" {
  type        = list(string)
  default     = []
  description = "The list of API's to activate within the project."
}

variable "activate_api_identities" {
  type = list(object({
    api   = string
    roles = list(string)
  }))
  default     = []
  description = <<EOF
    The list of service identities (Google Managed service account for the API) to force-create for the project (e.g. in order to grant additional roles).
    APIs in this list will automatically be appended to `activate_apis`.
    Not including the API in this list will follow the default behaviour for identity creation (which is usually when the first resource using the API is created).
    Any roles (e.g. service agent role) must be explicitly listed.
  EOF
}

variable "disable_on_destroy" {
  type        = bool
  default     = true
  description = "Whether to disable services on project deletion."
}

variable "disable_dependent_services" {
  type        = bool
  default     = true
  description = "Whether to disable dependent services on destruction."
}

variable "vpc_service_control_attach_enabled" {
  type        = bool
  default     = false
  description = "Whether the project will be attached to a VPC Service Control Perimeter in ENFORCED MODE. `vpc_service_control_attach_dry_run` should be `false` for this to be `true`."
}

variable "vpc_service_control_attach_dry_run" {
  type        = bool
  default     = false
  description = "Whether the project will be attached to a VPC Service Control Perimeter in Dry Run Mode. `vpc_service_control_attach_enabled` should be `false` for this to be `true`."
}

variable "vpc_service_control_sleep_duration" {
  type        = string
  default     = "5s"
  description = "The duration to sleep in seconds before adding the project to a shared VPC after the project is added to the VPC Service Control Perimeter. VPC-SC is eventually consistent."
}

variable "enable_shared_vpc_service_project" {
  type        = bool
  description = "Whether this project should be attached to a shared VPC. If `true`, you must set `shared_vpc` variable."
}

variable "shared_vpc" {
  type        = string
  default     = ""
  description = "The ID of the host project which hosts the shared VPC."
}

variable "enable_shared_vpc_host_project" {
  type        = bool
  default     = false
  description = "Whether this project is a shared VPC host project. If `true`, the `shared_vpc` variable must *not* be set. Default is `false`."
}

variable "default_service_account" {
  default     = "disable"
  type        = string
  description = "Project default service account setting. Defaults to `disable`."

  validation {
    condition     = contains(["delete", "deprivilege", "disable", "keep"], var.default_service_account)
    error_message = "Invalid value for default_service_account. Must be one of `delete`, `deprivilege`, `disable`, or `keep`."
  }
}

variable "create_project_sa" {
  type        = bool
  default     = true
  description = "Whether the default service account for the project shall be created. Defaults to `true`."
}

variable "project_sa_name" {
  type        = string
  default     = "project-service-account"
  description = "Default service account name for the project."
}

variable "sa_role" {
  type        = string
  default     = ""
  description = "A role to give the default Service Account for the project. Defaults to empty string."
}

variable "manage_group" {
  type        = bool
  default     = false
  description = "Whether a G Suite group should be managed. Defaults to `false`."
}

variable "group_email" {
  type        = string
  default     = ""
  description = "The email address of a group to control the project by being assigned `group_role`."
}

variable "group_role" {
  type        = string
  default     = ""
  description = "The role to give the controlling group (`group_name`) over the project."
}

variable "grant_network_role" {
  type        = bool
  default     = true
  description = "Whether to grant networkUser role on the host project and/or subnets. Defaults to `true`."
}

variable "shared_vpc_subnets" {
  type        = list(string)
  default     = []
  description = "List of subnets fully qualified subnet IDs (e.g. projects/$project_id/regions/$region/subnetworks/$subnet_id)."
}

variable "vpc_service_control_perimeter_name" {
  type        = string
  default     = null
  description = "The name of a VPC Service Control Perimeter to add the created project to. Default is `null`."
}

variable "default_network_tier" {
  type        = string
  default     = ""
  description = "Default Network Service Tier for resources created in this project."
}

variable "tag_binding_values" {
  type        = list(string)
  default     = []
  description = "Tag values to bind the project to."
}

variable "enable_audit_logs" {
  type        = bool
  default     = true
  description = "Enable audit logging for the project."
}

variable "create_audit_logs_storage" {
  type        = bool
  default     = true
  description = "Create a storage bucket for audit logs. Defaults to `true`."
}

variable "audit_logs_self_logging" {
  type        = bool
  default     = true
  description = "Enable access logging for the audit logs bucket itself."
}

variable "audit_logs_location" {
  type        = string
  default     = "europe-west4"
  description = "The location of the bucket that will store audit logs."
}

variable "audit_logs_retention_period" {
  type        = number
  default     = 2592000 # 30 days
  description = "The retention period for audit logs in seconds."
}

variable "audit_logs_lifecycle_age" {
  type        = number
  default     = 365 # 1 year
  description = "The age of audit logs in days before applying lifecycle rules."
}

variable "cloud_armor_tier" {
  type        = string
  default     = null
  description = "Managed protection tier to be set. Possible values are: CA_STANDARD, CA_ENTERPRISE_PAYGO. Defaults to `null`."

  validation {
    condition     = contains(["CA_STANDARD", "CA_ENTERPRISE_PAYGO", null], var.cloud_armor_tier)
    error_message = "Invalid value for cloud_armor_tier. Must be one of: `CA_STANDARD`, `CA_ENTERPRISE_PAYGO`, `null`."
  }
}
