locals {
  activate_compute_identity = 0 != length([for i in var.activate_api_identities : i if i.api == "compute.googleapis.com"])
  services                  = var.enable_apis ? toset(concat(var.activate_apis, [for i in var.activate_api_identities : i.api])) : toset([])
  service_identities = flatten([
    for i in var.activate_api_identities : [
      for r in i.roles :
      { api = i.api, role = r }
    ]
  ])

  add_service_roles = merge(
    {
      for si in local.service_identities :
      "${si.api} ${si.role}" => {
        email = google_project_service_identity.this[si.api].email
        role  = si.role
      }
      if si.api != "compute.googleapis.com"
    },
    {
      for si in local.service_identities :
      "${si.api} ${si.role}" => {
        email = data.google_compute_default_service_account.default[0].email
        role  = si.role
      }
      if si.api == "compute.googleapis.com"
    }
  )

  group_id          = var.manage_group ? format("group:%s", var.group_email) : ""
  project_org_id    = var.folder_id != "" ? null : var.org_id
  project_folder_id = var.folder_id != "" ? var.folder_id : null
  s_account_fmt = var.create_project_sa ? format(
    "serviceAccount:%s",
    try(google_service_account.default_service_account[0].email, ""),
  ) : ""
  api_s_account = format(
    "%s@cloudservices.gserviceaccount.com",
    google_project.this.number,
  )
  api_s_account_fmt = format("serviceAccount:%s", local.api_s_account)

  shared_vpc_users = compact(
    [
      local.group_id,
      local.s_account_fmt,
      local.api_s_account_fmt,
    ],
  )

  # Workaround for https://github.com/hashicorp/terraform/issues/10857
  shared_vpc_users_length = var.create_project_sa ? 3 : 2
}
