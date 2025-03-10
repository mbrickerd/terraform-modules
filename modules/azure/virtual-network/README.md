<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | n/a | yes |
| <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community) | The BGP community attribute in format <as-number>:<community-value>. | `string` | `null` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | A ddos\_protection\_plan block for DDoS Protection Plan on Virtual Network. | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of IP addresses of DNS servers. | `list(string)` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created. | `string` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | A encryption block to specify if the encrypted Virtual Network allows VMs that do not support encryption. | <pre>object({<br/>    enforcement = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specifies the environment the virtual network belongs to. | `string` | `"dev"` | no |
| <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes) | The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. | `number` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the virtual network is created. | `string` | `"westeurope"` | no |
| <a name="input_name"></a> [name](#input\_name) | The base name that will be used in the virtual network naming convention. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix name that will be used in the virtual network naming convention. | `string` | n/a | yes |
| <a name="input_private_endpoint_vnet_policies"></a> [private\_endpoint\_vnet\_policies](#input\_private\_endpoint\_vnet\_policies) | The Private Endpoint VNet Policies for the Virtual Network. Possible values are Disabled and Basic. Defaults to Disabled. | `string` | `"Disabled"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Virtual Network should be created. | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Can be specified multiple times to define multiple subnets. | <pre>list(object({<br/>    name                                          = string<br/>    address_prefixes                              = list(string)<br/>    security_group                                = optional(string)<br/>    default_outbound_access_enabled               = optional(bool, true)<br/>    route_table_id                                = optional(string)<br/>    service_endpoints                             = optional(list(string))<br/>    service_endpoint_policy_ids                   = optional(list(string))<br/>    private_endpoint_network_policies             = optional(string, "Disabled")<br/>    private_link_service_network_policies_enabled = optional(bool, true)<br/>    delegation = optional(list(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name    = string<br/>        actions = optional(list(string))<br/>      })<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the Virtual Network. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The list of address spaces used by the virtual network. |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | The list of DNS servers used by the virtual network. |
| <a name="output_guid"></a> [guid](#output\_guid) | The GUID of the virtual network. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the virtual network. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The list of names of the subnets that are attached to this virtual network. |
<!-- END_TF_DOCS -->
