<!-- BEGIN_TF_DOCS -->
Copyright 2025

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.50.0, < 6.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.50.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.45.2 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.45.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_artifact_registry_repository.repository](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_member.admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.readers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.writers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cleanup_policies"></a> [cleanup\_policies](#input\_cleanup\_policies) | Repository cleanup policies. | `any` | `{}` | no |
| <a name="input_cleanup_policy_dry_run"></a> [cleanup\_policy\_dry\_run](#input\_cleanup\_policy\_dry\_run) | Whether to cleanup policies run in dry run mode. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the repository. | `string` | `null` | no |
| <a name="input_docker_config"></a> [docker\_config](#input\_docker\_config) | Docker repository configuration. Defaults to `null`. | <pre>object({<br/>    immutable_tags = bool<br/>  })</pre> | `null` | no |
| <a name="input_format"></a> [format](#input\_format) | The format of the repository. | `string` | n/a | yes |
| <a name="input_iam_members"></a> [iam\_members](#input\_iam\_members) | IAM members to grant access to the repository. | <pre>object({<br/>    readers = optional(list(string), [])<br/>    writers = optional(list(string), [])<br/>    admins  = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | The name of the Cloud KMS key to use for repository encryption. Defaults to `null`. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The label mapping to be applied to the repository. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the repository. | `string` | n/a | yes |
| <a name="input_maven_config"></a> [maven\_config](#input\_maven\_config) | Maven repository configuration. Defaults to `null`. | <pre>object({<br/>    allow_snapshot_overwrites = bool<br/>    version_policy            = string<br/>  })</pre> | `null` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | The mode of the repository. Defaults to `STANDARD_REPOSITORY`. | `string` | `"STANDARD_REPOSITORY"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where the repository will be created. | `string` | n/a | yes |
| <a name="input_remote_repository_config"></a> [remote\_repository\_config](#input\_remote\_repository\_config) | Remote repository configuration (if mode = REMOTE\_REPOSITORY). Defaults to `null`. | `any` | `null` | no |
| <a name="input_repository_id"></a> [repository\_id](#input\_repository\_id) | The ID of the repository. | `string` | n/a | yes |
| <a name="input_virtual_repository_config"></a> [virtual\_repository\_config](#input\_virtual\_repository\_config) | Virtual repository configuration (if mode = VIRTUAL\_REPOSITORY). Defaults to `null`. | <pre>object({<br/>    upstream_policies = list(object({<br/>      id         = string<br/>      repository = string<br/>      priority   = number<br/>    }))<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | The time when the repository was created |
| <a name="output_format"></a> [format](#output\_format) | The format of the repository |
| <a name="output_is_apt_repository"></a> [is\_apt\_repository](#output\_is\_apt\_repository) | Whether this is an APT repository |
| <a name="output_is_docker_repository"></a> [is\_docker\_repository](#output\_is\_docker\_repository) | Whether this is a Docker repository |
| <a name="output_is_kfp_repository"></a> [is\_kfp\_repository](#output\_is\_kfp\_repository) | Whether this is a KFP repository |
| <a name="output_is_maven_repository"></a> [is\_maven\_repository](#output\_is\_maven\_repository) | Whether this is a Maven repository |
| <a name="output_is_npm_repository"></a> [is\_npm\_repository](#output\_is\_npm\_repository) | Whether this is an NPM repository |
| <a name="output_is_python_repository"></a> [is\_python\_repository](#output\_is\_python\_repository) | Whether this is a Python repository |
| <a name="output_is_yum_repository"></a> [is\_yum\_repository](#output\_is\_yum\_repository) | Whether this is a YUM repository |
| <a name="output_location"></a> [location](#output\_location) | The location of the created Artifact Registry repository |
| <a name="output_mode"></a> [mode](#output\_mode) | The mode of the repository |
| <a name="output_name"></a> [name](#output\_name) | The name of the created Artifact Registry repository |
| <a name="output_project"></a> [project](#output\_project) | The project ID of the created Artifact Registry repository |
| <a name="output_repository_hostname"></a> [repository\_hostname](#output\_repository\_hostname) | The hostname of the repository |
| <a name="output_repository_id"></a> [repository\_id](#output\_repository\_id) | The ID of the created Artifact Registry repository |
| <a name="output_repository_mode"></a> [repository\_mode](#output\_repository\_mode) | Repository mode information |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The full URL to the repository |
<!-- END_TF_DOCS -->
