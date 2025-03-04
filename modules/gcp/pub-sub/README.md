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
| [google_pubsub_subscription.subscriptions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the topic. | `map(string)` | `{}` | no |
| <a name="input_message_retention_duration"></a> [message\_retention\_duration](#input\_message\_retention\_duration) | Indicates the minimum duration to retain a message after it is published to the topic. | `string` | `null` | no |
| <a name="input_message_storage_policy"></a> [message\_storage\_policy](#input\_message\_storage\_policy) | Policy constraining the set of Google Cloud Platform regions where messages published to the topic may be stored. | <pre>object({<br/>    allowed_persistence_regions = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where the Pub/Sub topic will be created. | `string` | n/a | yes |
| <a name="input_schema_settings"></a> [schema\_settings](#input\_schema\_settings) | Settings for validating messages published against a schema. | <pre>object({<br/>    schema   = string<br/>    encoding = string<br/>  })</pre> | `null` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | A map of subscription configurations to create for the topic. | <pre>map(object({<br/>    name                       = string<br/>    ack_deadline_seconds       = optional(number)<br/>    retain_acked_messages      = optional(bool)<br/>    message_retention_duration = optional(string)<br/>    filter                     = optional(string)<br/>    expiration_policy_ttl      = optional(string)<br/>    dead_letter_policy = optional(object({<br/>      dead_letter_topic     = string<br/>      max_delivery_attempts = optional(number)<br/>    }))<br/>    retry_policy = optional(object({<br/>      minimum_backoff = optional(string)<br/>      maximum_backoff = optional(string)<br/>    }))<br/>    push_config = optional(object({<br/>      push_endpoint = string<br/>      attributes    = optional(map(string))<br/>      oidc_token = optional(object({<br/>        service_account_email = string<br/>        audience              = optional(string)<br/>      }))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the Pub/Sub topic. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_names"></a> [subscription\_names](#output\_subscription\_names) | A map of subscription names created with the topic. |
| <a name="output_subscriptions"></a> [subscriptions](#output\_subscriptions) | Map of subscription resources created with the topic. |
| <a name="output_topic"></a> [topic](#output\_topic) | The created Pub/Sub topic resource. |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | The ID of the Pub/Sub topic. |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | The name of the Pub/Sub topic. |
<!-- END_TF_DOCS -->
