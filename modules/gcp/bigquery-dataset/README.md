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
| [google_bigquery_dataset.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_deletion"></a> [allow\_deletion](#input\_allow\_deletion) | Whether to allow deletion of the BigQuery dataset when tables are present. | `bool` | `false` | no |
| <a name="input_dataset_id"></a> [dataset\_id](#input\_dataset\_id) | The ID of the BigQuery dataset. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to all applicable resources in this module. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the BigQuery dataset. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project where the BigQuery resources are being created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | An identifier for the resource with format `projects/{{project}}/datasets/{{dataset_id}}` |
<!-- END_TF_DOCS -->
