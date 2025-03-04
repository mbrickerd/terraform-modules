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
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | The CORS configuration for the bucket. | <pre>object({<br/>    origin          = list(string)<br/>    method          = list(string)<br/>    response_header = list(string)<br/>    max_age_seconds = number<br/>  })</pre> | `null` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | The Customer-Managed Encryption Key used to encrypt the bucket. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When deleting a bucket, this boolean option will delete all contained objects. | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the bucket. | `map(string)` | `{}` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | A list of lifecycle rules to configure. | <pre>list(object({<br/>    condition = object({<br/>      age                        = optional(number)<br/>      created_before             = optional(string)<br/>      with_state                 = optional(string)<br/>      matches_storage_class      = optional(list(string))<br/>      num_newer_versions         = optional(number)<br/>      days_since_noncurrent_time = optional(number)<br/>    })<br/>    action = object({<br/>      type          = string<br/>      storage_class = optional(string)<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the bucket. | `string` | `"europe-west4"` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | The bucket's Access & Storage Logs configuration. | <pre>object({<br/>    log_bucket        = string<br/>    log_object_prefix = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where the bucket will be created. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | The configuration of the bucket's retention policy. | <pre>object({<br/>    is_locked        = optional(bool, false)<br/>    retention_period = number<br/>  })</pre> | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | The storage class of the bucket. | `string` | `"STANDARD"` | no |
| <a name="input_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | Enables uniform bucket-level access on a bucket. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether to enable versioning for this bucket. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The created storage bucket resource. |
| <a name="output_name"></a> [name](#output\_name) | The name of the bucket. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the created bucket. |
| <a name="output_url"></a> [url](#output\_url) | The base URL of the bucket, in the format `gs://<bucket-name>`. |
<!-- END_TF_DOCS -->
