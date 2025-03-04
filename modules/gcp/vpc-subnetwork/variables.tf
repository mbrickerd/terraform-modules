variable "network" {
  type        = string
  description = "The network this subnet belongs to."
}

variable "name" {
  type        = string
  description = "The name of the subnetwork."
}

variable "description" {
  type        = string
  default     = null
  description = "An optional description of this subnetwork."
}

variable "ip_cidr_range" {
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."
}

variable "region" {
  type        = string
  default     = null
  description = "The region this subnetwork belongs to."
}

variable "role" {
  type        = string
  default     = null
  description = "The role of subnetwork."
}

variable "purpose" {
  type        = string
  default     = null
  description = "The purpose of the subnetwork."
}

variable "private_ip_google_access" {
  type        = bool
  default     = true
  description = "Whether to enable Google access for private IPv4 IP's."
}

variable "private_ipv6_google_access" {
  type        = bool
  default     = null
  description = "Whether to enable Google access for private IPv6 IP's."
}

variable "secondary_ip_ranges" {
  type        = list(map(string))
  default     = null
  description = "The secondary IP ranges to be used for this subnetwork."
}

variable "project" {
  type        = string
  default     = null
  description = "The project this subnetwork belongs to."
}

variable "disable_logging" {
  type        = bool
  default     = false
  description = "Whether to disable logging for the subnetwork."
}
