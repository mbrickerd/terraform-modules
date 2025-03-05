variable "prefix" {
  type        = string
  description = "The prefix name that will be used in the resource group naming convention."
}

variable "name" {
  type        = string
  description = "The base name that will be used in the resource group naming convention."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Specifies the environment the resource group belongs to."

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The Azure Region where the Resource Group should exist. Defaults to `westeurope`."
}

variable "managed_by" {
  type        = string
  default     = null
  description = "The ID of the resource or application that manages this Resource Group."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the Resource Group."
}
