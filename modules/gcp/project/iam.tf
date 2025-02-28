resource "google_service_account" "default_service_account" {
  count                        = var.create_project_sa ? 1 : 0
  account_id                   = var.project_sa_name
  display_name                 = "${var.name} Project Service Account"
  project                      = google_project.this.project_id
  create_ignore_already_exists = true
}

resource "google_project_iam_member" "default_service_account_membership" {
  count   = var.sa_role != "" && var.create_project_sa ? 1 : 0
  project = google_project.this.project_id
  role    = var.sa_role

  member = local.s_account_fmt
}

resource "google_project_iam_member" "gsuite_group_role" {
  count = var.manage_group ? 1 : 0

  member  = local.group_id
  project = google_project.this.project_id
  role    = var.group_role
}

resource "google_service_account_iam_member" "service_account_grant_to_group" {
  count = var.manage_group && var.create_project_sa ? 1 : 0

  member = local.group_id
  role   = "roles/iam.serviceAccountUser"

  service_account_id = "projects/${google_project.this.project_id}/serviceAccounts/${google_service_account.default_service_account[0].email}"
}

resource "google_project_iam_member" "controlling_group_vpc_membership" {
  count = var.grant_network_role && var.enable_shared_vpc_service_project && length(var.shared_vpc_subnets) == 0 ? local.shared_vpc_users_length : 0

  project = var.shared_vpc
  role    = "roles/compute.networkUser"
  member  = element(local.shared_vpc_users, count.index)

  depends_on = [
    google_project_service.this,
    google_project_service_identity.this,
    google_project_iam_member.this
  ]
}

resource "google_compute_subnetwork_iam_member" "service_account_role_to_vpc_subnets" {
  provider = google-beta
  count    = var.grant_network_role && var.enable_shared_vpc_service_project && length(var.shared_vpc_subnets) > 0 && var.create_project_sa ? length(var.shared_vpc_subnets) : 0

  subnetwork = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(
      split("/", var.shared_vpc_subnets[count.index]),
      "subnetworks",
    ) + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(split("/", var.shared_vpc_subnets[count.index]), "regions") + 1,
  )
  project = var.shared_vpc
  member  = local.s_account_fmt
}

resource "google_compute_subnetwork_iam_member" "group_role_to_vpc_subnets" {
  provider = google-beta

  count = var.grant_network_role && var.enable_shared_vpc_service_project && length(var.shared_vpc_subnets) > 0 && var.manage_group ? length(var.shared_vpc_subnets) : 0
  subnetwork = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(
      split("/", var.shared_vpc_subnets[count.index]),
      "subnetworks",
    ) + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(split("/", var.shared_vpc_subnets[count.index]), "regions") + 1,
  )
  member  = local.group_id
  project = var.shared_vpc
}

resource "google_compute_subnetwork_iam_member" "apis_service_account_role_to_vpc_subnets" {
  provider = google-beta

  count = var.grant_network_role && var.enable_shared_vpc_service_project && length(var.shared_vpc_subnets) > 0 ? length(var.shared_vpc_subnets) : 0
  subnetwork = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(
      split("/", var.shared_vpc_subnets[count.index]),
      "subnetworks",
    ) + 1,
  )
  role = "roles/compute.networkUser"
  region = element(
    split("/", var.shared_vpc_subnets[count.index]),
    index(split("/", var.shared_vpc_subnets[count.index]), "regions") + 1,
  )
  project = var.shared_vpc
  member  = local.api_s_account_fmt

  depends_on = [
    google_project_service.this,
    google_project_service_identity.this,
    google_project_iam_member.this
  ]
}
