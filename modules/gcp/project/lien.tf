/**
 * # Google Cloud Project Lien
 *
 * This module creates a protective lien on the Google Cloud Platform project to prevent
 * accidental deletion of critical infrastructure resources. The lien serves as a safeguard
 * for the underlying project container.
 *
 * The lien:
 * - Requires explicit removal before project deletion can proceed
 * - Is conditionally applied based on the 'lien' variable setting
 * - Provides a clear reason and origin designation for administrative transparency
 * - Prevents unintended disruption to your data pipeline and stream processing
 *
 * This provides an additional layer of protection beyond IAM permissions to ensure
 * production environments remain stable and protected from accidental deletion.
 */

resource "google_resource_manager_lien" "this" {
  count        = var.lien ? 1 : 0
  parent       = "projects/${google_project.this.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "project-factory"
  reason       = "Project Factory lien"
}
