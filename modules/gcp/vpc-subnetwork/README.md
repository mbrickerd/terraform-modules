<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.41, < 7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.41, < 7 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_subnetwork.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | An optional description of this subnetwork. | `string` | `null` | no |
| <a name="input_disable_logging"></a> [disable\_logging](#input\_disable\_logging) | Whether to disable logging for the subnetwork. | `bool` | `false` | no |
| <a name="input_ip_cidr_range"></a> [ip\_cidr\_range](#input\_ip\_cidr\_range) | The range of internal addresses that are owned by this subnetwork. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the subnetwork. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The network this subnet belongs to. | `string` | n/a | yes |
| <a name="input_private_ip_google_access"></a> [private\_ip\_google\_access](#input\_private\_ip\_google\_access) | Whether to enable Google access for private IPv4 IP's. | `bool` | `true` | no |
| <a name="input_private_ipv6_google_access"></a> [private\_ipv6\_google\_access](#input\_private\_ipv6\_google\_access) | Whether to enable Google access for private IPv6 IP's. | `bool` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The project this subnetwork belongs to. | `string` | `null` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The purpose of the subnetwork. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region this subnetwork belongs to. | `string` | `null` | no |
| <a name="input_role"></a> [role](#input\_role) | The role of subnetwork. | `string` | `null` | no |
| <a name="input_secondary_ip_ranges"></a> [secondary\_ip\_ranges](#input\_secondary\_ip\_ranges) | The secondary IP ranges to be used for this subnetwork. | `list(map(string))` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_creation_timestamp"></a> [creation\_timestamp](#output\_creation\_timestamp) | Creation timestamp in RFC3339 text format |
| <a name="output_gateway_address"></a> [gateway\_address](#output\_gateway\_address) | The gateway address for default routes to reach destination addresses outside this subnetwork |
| <a name="output_id"></a> [id](#output\_id) | Identifier for the subnetwork |
| <a name="output_ip_cidr_range"></a> [ip\_cidr\_range](#output\_ip\_cidr\_range) | IP CIDR range for the subnetwork |
| <a name="output_name"></a> [name](#output\_name) | Name of the subnetwork |
| <a name="output_region"></a> [region](#output\_region) | Region where the subnetwork is created in |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created resource |
<!-- END_TF_DOCS -->
