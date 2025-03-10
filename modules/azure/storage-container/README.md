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
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | The Access Level configured for this Container. Defaults to `private`. | `string` | `"private"` | no |
| <a name="input_default_encryption_scope"></a> [default\_encryption\_scope](#input\_default\_encryption\_scope) | The default encryption scope to use for blobs uploaded to this container. | `string` | `null` | no |
| <a name="input_encryption_scope_override_enabled"></a> [encryption\_scope\_override\_enabled](#input\_encryption\_scope\_override\_enabled) | Whether to allow blobs to override the default encryption scope for this container. Can only be set when specifying `default_encryption_scope`. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | A mapping of MetaData for this Container. All metadata keys should be lowercase. | `map(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container which should be created within the Storage Account. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the Storage Account where the Container should be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_has_immutability_policy"></a> [has\_immutability\_policy](#output\_has\_immutability\_policy) | Whether there is an Immutability Policy configured on this Storage Container. |
| <a name="output_has_legal_hold"></a> [has\_legal\_hold](#output\_has\_legal\_hold) | Whether there is a Legal Hold configured on this Storage Container. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Container. |
| <a name="output_resource_manager_id"></a> [resource\_manager\_id](#output\_resource\_manager\_id) | The Resource Manager ID of this Storage Container. |
<!-- END_TF_DOCS -->
