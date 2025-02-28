locals {
  # Default formats for different repository types
  format_docker = var.format == "DOCKER"
  format_maven  = var.format == "MAVEN"
  format_npm    = var.format == "NPM"
  format_python = var.format == "PYTHON"
  format_apt    = var.format == "APT"
  format_yum    = var.format == "YUM"
  format_kfp    = var.format == "KFP"

  # Repository modes
  is_standard_repository = var.mode == "STANDARD_REPOSITORY"
  is_virtual_repository  = var.mode == "VIRTUAL_REPOSITORY"
  is_remote_repository   = var.mode == "REMOTE_REPOSITORY"

  # Generate a valid repository URL based on format
  repository_url = {
    "DOCKER"  = "${var.location}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
    "MAVEN"   = "${var.location}-maven.pkg.dev/${var.project_id}/${var.repository_id}"
    "NPM"     = "${var.location}-npm.pkg.dev/${var.project_id}/${var.repository_id}"
    "PYTHON"  = "${var.location}-python.pkg.dev/${var.project_id}/${var.repository_id}"
    "APT"     = "${var.location}-apt.pkg.dev/${var.project_id}/${var.repository_id}"
    "YUM"     = "${var.location}-yum.pkg.dev/${var.project_id}/${var.repository_id}"
    "KFP"     = "${var.location}-kfp.pkg.dev/${var.project_id}/${var.repository_id}"
    "default" = "${var.location}.pkg.dev/${var.project_id}/${var.repository_id}"
  }[var.format]

  # Default repository settings based on format
  default_docker_config = var.docker_config != null ? var.docker_config : local.format_docker ? { immutable_tags = false } : null

  default_maven_config = var.maven_config != null ? var.maven_config : local.format_maven ? {
    allow_snapshot_overwrites = true
    version_policy            = "RELEASE"
  } : null
}
