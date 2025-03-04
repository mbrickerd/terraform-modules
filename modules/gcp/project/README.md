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
| [google_project.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_resource_manager_lien.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/resource_manager_lien) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | Controls whether the 'default' network exists on the project. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The alphanumeric ID of the billing account this project belongs to. | `string` | n/a | yes |
| <a name="input_deletion_policy"></a> [deletion\_policy](#input\_deletion\_policy) | The deletion policy for the Project. Setting PREVENT will protect the project against any destroy actions caused by a `terraform apply` or `terraform destroy`. | `string` | `"PREVENT"` | no |
| <a name="input_deletion_prevention"></a> [deletion\_prevention](#input\_deletion\_prevention) | Block that covers various properties around project liens. | <pre>object({<br/>    reasons     = list(string)<br/>    skip_delete = optional(bool),<br/>  })</pre> | <pre>{<br/>  "reasons": [],<br/>  "skip_delete": true<br/>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specifies the environment the Google project belongs to. | `string` | `"dev"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder where this project will be created. | `string` | `null` | no |
| <a name="input_google_apis"></a> [google\_apis](#input\_google\_apis) | A list of Google services to enable in the project. | `list(string)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the project. Note: This field is non-authoritative, and will only manage the labels present in your configuration. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The base name that will be used in the Google project naming convention. | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The numeric ID of the organization this project belongs to. | `number` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix name that will be used in the Google project naming convention. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | An identifier for the project resource with format `projects/{{project}}`. |
| <a name="output_number"></a> [number](#output\_number) | The numeric identifier of the project. |
<!-- END_TF_DOCS -->
