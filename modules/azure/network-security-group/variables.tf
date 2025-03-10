variable "resource_group_name" {
  description = "The name of the Resource Group where the NSG should be created."
  type        = string
}

variable "prefix" {
  description = "The prefix name that will be used in the NSG naming convention."
  type        = string
}

variable "name" {
  description = "The base name that will be used in the NSG naming convention."
  type        = string
}

variable "environment" {
  description = "Specifies the environment the NSG belongs to."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "location" {
  description = "Specifies the supported Azure location where the NSG exists."
  type        = string
  default     = "westeurope"
}

variable "security_rules" {
  description = "A list of security rules to be applied to the NSG."
  type = list(object({
    name                                       = string
    description                                = optional(string)
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
    access                                     = string
    priority                                   = number
    direction                                  = string
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.security_rules : contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)
    ])
    error_message = "Invalid value for security_rules.rule. Must be one of: `Tcp`, `Udp`, `Icmp`, `Esp`, `Ah`, `*` (which matches all)."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : (
        (rule.source_port_range != null && rule.source_port_ranges == null) ||
        (rule.source_port_range == null && rule.source_port_ranges != null) ||
        (rule.source_port_range != null && rule.source_port_ranges != null)
      )
    ])
    error_message = "Either source_port_range or source_port_ranges must be specified."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : (
        (rule.destination_port_range != null && rule.destination_port_ranges == null) ||
        (rule.destination_port_range == null && rule.destination_port_ranges != null) ||
        (rule.destination_port_range != null && rule.destination_port_ranges != null)
      )
    ])
    error_message = "Either destination_port_range or destination_port_ranges must be specified."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : (
        (rule.source_address_prefix != null && rule.source_address_prefixes == null) ||
        (rule.source_address_prefix == null && rule.source_address_prefixes != null) ||
        (rule.source_address_prefix != null && rule.source_address_prefixes != null) ||
        (rule.source_application_security_group_ids != null)
      )
    ])
    error_message = "Either source_address_prefix, source_address_prefixes, or source_application_security_group_ids must be specified."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : (
        (rule.destination_address_prefix != null && rule.destination_address_prefixes == null) ||
        (rule.destination_address_prefix == null && rule.destination_address_prefixes != null) ||
        (rule.destination_address_prefix != null && rule.destination_address_prefixes != null) ||
        (rule.destination_application_security_group_ids != null)
      )
    ])
    error_message = "Either destination_address_prefix, destination_address_prefixes, or destination_application_security_group_ids must be specified."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "Access must be either `Allow` or `Deny`."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : rule.priority >= 100 && rule.priority <= 4096
    ])
    error_message = "Priority must be between 100 and 4096."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "Direction must be either `Inbound` or `Outbound`."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules : (
        rule.description == null || length(rule.description) <= 140
      )
    ])
    error_message = "Description is restricted to 140 characters."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the NSG."
  type        = map(string)
  default     = {}
}
