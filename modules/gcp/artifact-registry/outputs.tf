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

output "repository_id" {
  description = "The ID of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.repository.repository_id
}

output "name" {
  description = "The name of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.repository.name
}

output "location" {
  description = "The location of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.repository.location
}

output "project" {
  description = "The project ID of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.repository.project
}

output "create_time" {
  description = "The time when the repository was created"
  value       = google_artifact_registry_repository.repository.create_time
}

output "format" {
  description = "The format of the repository"
  value       = google_artifact_registry_repository.repository.format
}

output "mode" {
  description = "The mode of the repository"
  value       = google_artifact_registry_repository.repository.mode
}

output "repository_hostname" {
  description = "The hostname of the repository"
  value       = join(".", [google_artifact_registry_repository.repository.location, "artifacts", "${google_artifact_registry_repository.repository.project}.appspot.com"])
}

output "repository_url" {
  description = "The full URL to the repository"
  value       = local.repository_url
}

# Additional format-specific outputs to use locals
output "is_docker_repository" {
  description = "Whether this is a Docker repository"
  value       = local.format_docker
}

output "is_maven_repository" {
  description = "Whether this is a Maven repository"
  value       = local.format_maven
}

output "is_npm_repository" {
  description = "Whether this is an NPM repository"
  value       = local.format_npm
}

output "is_python_repository" {
  description = "Whether this is a Python repository"
  value       = local.format_python
}

output "is_apt_repository" {
  description = "Whether this is an APT repository"
  value       = local.format_apt
}

output "is_yum_repository" {
  description = "Whether this is a YUM repository"
  value       = local.format_yum
}

output "is_kfp_repository" {
  description = "Whether this is a KFP repository"
  value       = local.format_kfp
}

output "repository_mode" {
  description = "Repository mode information"
  value = {
    is_standard = local.is_standard_repository
    is_virtual  = local.is_virtual_repository
    is_remote   = local.is_remote_repository
  }
}
