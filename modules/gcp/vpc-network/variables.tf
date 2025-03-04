variable "name" {
  type        = string
  description = "The name of the network."
}

variable "description" {
  type        = string
  default     = null
  description = "An optional description of this network."
}

variable "auto_create_subnetworks" {
  type        = bool
  default     = false
  description = "When set to `true`, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the `10.128.0.0/9` address range."
}

variable "create_quadzero_route" {
  type        = bool
  default     = true
  description = "When set to `true`, a route to the public internet will be created."
}

variable "routing_mode" {
  type        = string
  default     = null
  description = "The network-wide routing mode to use."
}

variable "mtu" {
  type        = number
  default     = null
  description = "Maximum Transmission Unit in bytes."
}

variable "enable_private_google_connectivity" {
  type        = bool
  default     = true
  description = "If set to `true`, a firewall will be created to allow access to Google's private service IP ranges."
}

variable "allow_iap_ingress" {
  type        = bool
  default     = true
  description = "If set to `true`, a firewall will be created to allow ingress access for IAP TCP forwarding."
}

variable "allow_loadbalancer_health_checks" {
  type        = bool
  default     = true
  description = "If set to `true`, a firewall will be created to allow inbound Google Load Balancer health checks."
}

variable "deny_all_ingress" {
  type        = bool
  default     = false
  description = "If set to `true`, a deny-all firewall will be created to deny all ingress traffic. If set to `false`, a route to the public internet will be created."
}

variable "deny_all_egress" {
  type        = bool
  default     = false
  description = "If set to `true`, a deny-all firewall will be created to deny all egress traffic."
}

variable "project" {
  type        = string
  default     = null
  description = "The project this network belongs to."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "The label mappings for the network."
}
