resource "azurerm_virtual_network" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  bgp_community                  = var.bgp_community
  dns_servers                    = var.dns_servers
  edge_zone                      = var.edge_zone
  flow_timeout_in_minutes        = var.flow_timeout_in_minutes
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies
  tags                           = local.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

  dynamic "subnet" {
    for_each = var.subnet
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      security_group                                = lookup(subnet.value, "security_group", null)
      default_outbound_access_enabled               = lookup(subnet.value, "default_outbound_access_enabled", true)
      route_table_id                                = lookup(subnet.value, "route_table_id", null)
      service_endpoints                             = lookup(subnet.value, "service_endpoints", null)
      service_endpoint_policy_ids                   = lookup(subnet.value, "service_endpoint_policy_ids", null)
      private_endpoint_network_policies             = lookup(subnet.value, "private_endpoint_network_policies", "Disabled")
      private_link_service_network_policies_enabled = lookup(subnet.value, "private_link_service_network_policies_enabled", true)

      dynamic "delegation" {
        for_each = lookup(subnet.value, "delegation", [])
        content {
          name = delegation.value.name

          service_delegation {
            name    = delegation.value.service_delegation.name
            actions = lookup(delegation.value.service_delegation, "actions", null)
          }
        }
      }
    }
  }
}
