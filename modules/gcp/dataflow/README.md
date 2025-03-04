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
| [google_dataflow_job.job](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataflow_job) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_experiments"></a> [additional\_experiments](#input\_additional\_experiments) | A list of experiments to enable for the job. | `list(string)` | `null` | no |
| <a name="input_dependencies"></a> [dependencies](#input\_dependencies) | A list of resources the Dataflow job depends on. | `list(any)` | `[]` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | The configuration for VM IPs. Possible values are are 'WORKER\_IP\_PUBLIC' or 'WORKER\_IP\_PRIVATE'. | `string` | `null` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | The name for the Cloud KMS key to protect the job. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | User labels to be specified for the job. | `map(string)` | `{}` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type to use for the job. Defaults to `n1-standard-2`. | `string` | `"n1-standard-2"` | no |
| <a name="input_max_workers"></a> [max\_workers](#input\_max\_workers) | The maximum number of workers permitted for the job. Defaults to 2. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Dataflow job. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The network to which VMs will be assigned. | `string` | `null` | no |
| <a name="input_on_delete"></a> [on\_delete](#input\_on\_delete) | Specifies behavior of deletion during `terraform destroy`. Possible values are 'drain' or 'cancel'. | `string` | `"drain"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A set of key/value pairs to be passed to the Dataflow job. | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID where the Dataflow job will be created. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the Dataflow job will run. Defaults to `europe-west4`. | `string` | `"europe-west4"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | The service account email to run the job as. | `string` | `null` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to which VMs will be assigned. | `string` | `null` | no |
| <a name="input_temp_gcs_location"></a> [temp\_gcs\_location](#input\_temp\_gcs\_location) | The GCS location for temporary files during job execution. | `string` | n/a | yes |
| <a name="input_template_gcs_path"></a> [template\_gcs\_path](#input\_template\_gcs\_path) | The GCS path to the Dataflow job template. | `string` | n/a | yes |
| <a name="input_transform_name_mapping"></a> [transform\_name\_mapping](#input\_transform\_name\_mapping) | Only applicable when updating a pipeline. Map of transform name replacements. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_job_ids"></a> [job\_ids](#output\_job\_ids) | Map of job names to their Dataflow job ID's. |
| <a name="output_job_names"></a> [job\_names](#output\_job\_names) | Map of job keys to their names. |
| <a name="output_job_states"></a> [job\_states](#output\_job\_states) | Map of job names to their current states. |
<!-- END_TF_DOCS -->
