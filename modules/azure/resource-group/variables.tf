variable "prefix" {
  description = "The prefix name that will be used in the resource group naming convention."
  type        = string
}

variable "name" {
  description = "The base name that will be used in the resource group naming convention."
  type        = string
}

variable "environment" {
  description = "Specifies the environment the resource group belongs to."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "location" {
  description = "The Azure Region where the Resource Group should exist. Defaults to `westeurope`."
  type        = string
  default     = "westeurope"
}

variable "managed_by" {
  description = "The ID of the resource or application that manages this Resource Group."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group."
  type        = map(string)
  default     = {}
}
