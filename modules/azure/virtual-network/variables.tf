variable "resource_group_name" {
  description = "The name of the Resource Group where the Virtual Network should be created."
  type        = string
}

variable "prefix" {
  description = "The prefix name that will be used in the virtual network naming convention."
  type        = string
}

variable "name" {
  description = "The base name that will be used in the virtual network naming convention."
  type        = string
}

variable "environment" {
  description = "Specifies the environment the virtual network belongs to."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "location" {
  description = "Specifies the supported Azure location where the virtual network is created."
  type        = string
  default     = "westeurope"
}

variable "address_space" {
  description = "The address space that is used the virtual network. You can supply more than one address space."
  type        = list(string)
}

variable "bgp_community" {
  description = "The BGP community attribute in format <as-number>:<community-value>."
  type        = string
  default     = null
}

variable "ddos_protection_plan" {
  description = "A ddos_protection_plan block for DDoS Protection Plan on Virtual Network."
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "encryption" {
  description = "A encryption block to specify if the encrypted Virtual Network allows VMs that do not support encryption."
  type = object({
    enforcement = string
  })
  default = null

  validation {
    condition     = var.encryption == null || var.encryption.enforcement == "AllowUnencrypted"
    error_message = "Currently only 'AllowUnencrypted' is supported for the encryption enforcement property."
  }
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers."
  type        = list(string)
  default     = null
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created."
  type        = string
  default     = null
}

variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  type        = number
  default     = null

  validation {
    condition     = var.flow_timeout_in_minutes == null || (var.flow_timeout_in_minutes >= 4 && var.flow_timeout_in_minutes <= 30)
    error_message = "The flow_timeout_in_minutes value must be between 4 and 30 minutes."
  }
}

variable "subnet" {
  description = "Can be specified multiple times to define multiple subnets."
  type = list(object({
    name                                          = string
    address_prefixes                              = list(string)
    security_group                                = optional(string)
    default_outbound_access_enabled               = optional(bool, true)
    route_table_id                                = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    private_endpoint_network_policies             = optional(string, "Disabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))
  default = []

  validation {
    condition = alltrue([
      for s in var.subnet : s.private_endpoint_network_policies == null ||
      contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], s.private_endpoint_network_policies)
    ])
    error_message = "private_endpoint_network_policies must be one of: Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled."
  }
}

variable "private_endpoint_vnet_policies" {
  description = "The Private Endpoint VNet Policies for the Virtual Network. Possible values are Disabled and Basic. Defaults to Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Basic"], var.private_endpoint_vnet_policies)
    error_message = "The private_endpoint_vnet_policies value must be either 'Disabled' or 'Basic'."
  }
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Virtual Network."
  type        = map(string)
  default     = {}
}
