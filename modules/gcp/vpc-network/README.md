<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.41, < 7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow_iap_ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.deny_all_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.deny_all_ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.enable_private_google_connectivity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.lb_health_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_route.private_google_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.public_internet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_compute_route.restricted_google_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) | resource |
| [google_dns_managed_zone.zones](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.a_records](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.cname_records](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_netblock_ip_ranges.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/netblock_ip_ranges) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_iap_ingress"></a> [allow\_iap\_ingress](#input\_allow\_iap\_ingress) | If set to `true`, a firewall will be created to allow ingress access for IAP TCP forwarding. | `bool` | `true` | no |
| <a name="input_allow_loadbalancer_health_checks"></a> [allow\_loadbalancer\_health\_checks](#input\_allow\_loadbalancer\_health\_checks) | If set to `true`, a firewall will be created to allow inbound Google Load Balancer health checks. | `bool` | `true` | no |
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to `true`, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the `10.128.0.0/9` address range. | `bool` | `false` | no |
| <a name="input_create_quadzero_route"></a> [create\_quadzero\_route](#input\_create\_quadzero\_route) | When set to `true`, a route to the public internet will be created. | `bool` | `true` | no |
| <a name="input_deny_all_egress"></a> [deny\_all\_egress](#input\_deny\_all\_egress) | If set to `true`, a deny-all firewall will be created to deny all egress traffic. | `bool` | `false` | no |
| <a name="input_deny_all_ingress"></a> [deny\_all\_ingress](#input\_deny\_all\_ingress) | If set to `true`, a deny-all firewall will be created to deny all ingress traffic. If set to `false`, a route to the public internet will be created. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this network. | `string` | `null` | no |
| <a name="input_enable_private_google_connectivity"></a> [enable\_private\_google\_connectivity](#input\_enable\_private\_google\_connectivity) | If set to `true`, a firewall will be created to allow access to Google's private service IP ranges. | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The label mappings for the network. | `map(string)` | `{}` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | Maximum Transmission Unit in bytes. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the network. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project this network belongs to. | `string` | `null` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network-wide routing mode to use. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_ipv4"></a> [gateway\_ipv4](#output\_gateway\_ipv4) | The gateway address for default routing out of the network. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier for the network. |
| <a name="output_name"></a> [name](#output\_name) | The name of the network. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created network. |
<!-- END_TF_DOCS -->
