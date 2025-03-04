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
| [google_project_iam_member.project_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account ID for the service account. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A description of the service account. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the service account. | `string` | `null` | no |
| <a name="input_impersonation_enabled"></a> [impersonation\_enabled](#input\_impersonation\_enabled) | Whether to enable the service account impersonation feature. | `bool` | `false` | no |
| <a name="input_impersonation_service_accounts"></a> [impersonation\_service\_accounts](#input\_impersonation\_service\_accounts) | A list of service accounts that can impersonate this service account. | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID where the service account will be created. | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | The IAM roles to assign to the service account in the project. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email"></a> [email](#output\_email) | The email address of the service account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the service account. |
| <a name="output_name"></a> [name](#output\_name) | The fully-qualified name of the service account. |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | The unique ID of the service account. |
<!-- END_TF_DOCS -->
