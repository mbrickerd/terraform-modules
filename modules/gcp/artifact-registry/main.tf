/**
 * Copyright 2025
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Main Artifact Registry repository resource
resource "google_artifact_registry_repository" "repository" {
  provider = google-beta

  repository_id = var.repository_id
  location      = var.location
  format        = var.format
  project       = var.project_id
  mode          = var.mode
  description   = var.description
  labels = merge(var.labels, {
    format_type   = var.format
    is_npm        = local.format_npm ? "true" : "false"
    is_python     = local.format_python ? "true" : "false"
    is_apt        = local.format_apt ? "true" : "false"
    is_yum        = local.format_yum ? "true" : "false"
    is_kfp        = local.format_kfp ? "true" : "false"
    standard_repo = local.is_standard_repository ? "true" : "false"
  })

  # Conditional CMEK encryption
  kms_key_name = var.kms_key_name

  # Format-specific configurations
  # Apply Docker configuration only if format is DOCKER
  dynamic "docker_config" {
    for_each = local.format_docker && local.default_docker_config != null ? [local.default_docker_config] : []
    content {
      immutable_tags = docker_config.value.immutable_tags
    }
  }

  # Apply Maven configuration only if format is MAVEN
  dynamic "maven_config" {
    for_each = local.format_maven && local.default_maven_config != null ? [local.default_maven_config] : []
    content {
      allow_snapshot_overwrites = maven_config.value.allow_snapshot_overwrites
      version_policy            = maven_config.value.version_policy
    }
  }

  # Virtual repository configuration (for mode = "VIRTUAL")
  dynamic "virtual_repository_config" {
    for_each = local.is_virtual_repository && var.virtual_repository_config != null ? [var.virtual_repository_config] : []
    content {
      dynamic "upstream_policies" {
        for_each = virtual_repository_config.value.upstream_policies != null ? virtual_repository_config.value.upstream_policies : []
        content {
          id         = upstream_policies.value.id
          repository = upstream_policies.value.repository
          priority   = upstream_policies.value.priority
        }
      }
    }
  }

  # Remote repository configuration (for mode = "REMOTE")
  dynamic "remote_repository_config" {
    for_each = local.is_remote_repository && var.remote_repository_config != null ? [var.remote_repository_config] : []
    content {
      description = remote_repository_config.value.description

      disable_upstream_validation = lookup(remote_repository_config.value, "disable_upstream_validation", false)

      dynamic "upstream_credentials" {
        for_each = lookup(remote_repository_config.value, "upstream_credentials", null) != null ? [remote_repository_config.value.upstream_credentials] : []
        content {
          username_password_credentials {
            username                = upstream_credentials.value.username
            password_secret_version = upstream_credentials.value.password_secret_version
          }
        }
      }

      # Repository type-specific configurations
      dynamic "apt_repository" {
        for_each = lookup(remote_repository_config.value, "apt_repository", null) != null ? [remote_repository_config.value.apt_repository] : []
        content {
          dynamic "public_repository" {
            for_each = lookup(apt_repository.value, "public_repository", null) != null ? [apt_repository.value.public_repository] : []
            content {
              repository_base = public_repository.value.repository_base
              repository_path = public_repository.value.repository_path
            }
          }
        }
      }

      dynamic "docker_repository" {
        for_each = lookup(remote_repository_config.value, "docker_repository", null) != null ? [remote_repository_config.value.docker_repository] : []
        content {
          public_repository = lookup(docker_repository.value, "public_repository", null)
          dynamic "custom_repository" {
            for_each = lookup(docker_repository.value, "custom_repository", null) != null ? [docker_repository.value.custom_repository] : []
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "maven_repository" {
        for_each = lookup(remote_repository_config.value, "maven_repository", null) != null ? [remote_repository_config.value.maven_repository] : []
        content {
          public_repository = lookup(maven_repository.value, "public_repository", null)
          dynamic "custom_repository" {
            for_each = lookup(maven_repository.value, "custom_repository", null) != null ? [maven_repository.value.custom_repository] : []
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "npm_repository" {
        for_each = lookup(remote_repository_config.value, "npm_repository", null) != null ? [remote_repository_config.value.npm_repository] : []
        content {
          public_repository = lookup(npm_repository.value, "public_repository", null)
          dynamic "custom_repository" {
            for_each = lookup(npm_repository.value, "custom_repository", null) != null ? [npm_repository.value.custom_repository] : []
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "python_repository" {
        for_each = lookup(remote_repository_config.value, "python_repository", null) != null ? [remote_repository_config.value.python_repository] : []
        content {
          public_repository = lookup(python_repository.value, "public_repository", null)
          dynamic "custom_repository" {
            for_each = lookup(python_repository.value, "custom_repository", null) != null ? [python_repository.value.custom_repository] : []
            content {
              uri = custom_repository.value.uri
            }
          }
        }
      }

      dynamic "yum_repository" {
        for_each = lookup(remote_repository_config.value, "yum_repository", null) != null ? [remote_repository_config.value.yum_repository] : []
        content {
          dynamic "public_repository" {
            for_each = lookup(yum_repository.value, "public_repository", null) != null ? [yum_repository.value.public_repository] : []
            content {
              repository_base = public_repository.value.repository_base
              repository_path = public_repository.value.repository_path
            }
          }
        }
      }
    }
  }

  # Cleanup policy configuration
  cleanup_policy_dry_run = var.cleanup_policy_dry_run

  dynamic "cleanup_policies" {
    for_each = var.cleanup_policies
    content {
      id     = cleanup_policies.key
      action = cleanup_policies.value.action

      dynamic "condition" {
        for_each = lookup(cleanup_policies.value, "condition", null) != null ? [cleanup_policies.value.condition] : []
        content {
          tag_state             = lookup(condition.value, "tag_state", null)
          tag_prefixes          = lookup(condition.value, "tag_prefixes", null)
          older_than            = lookup(condition.value, "older_than", null)
          newer_than            = lookup(condition.value, "newer_than", null)
          version_name_prefixes = lookup(condition.value, "version_name_prefixes", null)
          package_name_prefixes = lookup(condition.value, "package_name_prefixes", null)
        }
      }

      dynamic "most_recent_versions" {
        for_each = lookup(cleanup_policies.value, "most_recent_versions", null) != null ? [cleanup_policies.value.most_recent_versions] : []
        content {
          keep_count            = most_recent_versions.value.keep_count
          package_name_prefixes = lookup(most_recent_versions.value, "package_name_prefixes", null)
        }
      }
    }
  }
}
