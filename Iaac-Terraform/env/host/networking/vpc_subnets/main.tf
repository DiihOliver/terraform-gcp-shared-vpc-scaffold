# Networking details - VPC, Subnets, PrivateServiceAccess and Cloud NAT Module
module "svc_project_networking" {
  for_each         = var.svc_project_networking
  source           = "../../../../modules/networking/shared-vpc"
  network_name     = each.value.network_name
  project_id       = var.host_project_id
  routing_mode     = each.value.routing_mode
  subnets          = each.value.subnets
  secondary_ranges = each.value.secondary_ranges
}

# Enable A Shared VPC in the host project
resource "google_compute_shared_vpc_host_project" "host" {
  project    = var.host_project_id
  depends_on = [module.svc_project_networking]
}

resource "google_compute_shared_vpc_service_project" "service_project_attachment" {
  for_each = toset(var.service_project_ids)
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = each.key
  depends_on      = [google_compute_shared_vpc_host_project.host]
}

locals {
  subnet_sharing_bindings = flatten([
    # Outer loop: iterate over service projects (e.g., "my-service-project-1")
    for sp_id, subnet_to_sa_list_map in var.service_project_subnet_sharing : [
      # Middle loop: iterate over the subnets for this service project (e.g., "projects/.../subnet-a")
      for subnet_path, sa_email_list in subnet_to_sa_list_map : [
        # Inner loop: iterate over the list of service accounts for this specific subnet
        for sa_email in sa_email_list : {
          service_project_id = sp_id
          subnet_path        = subnet_path
          custom_sa_email    = sa_email
          binding_key = "binding-for-${sp_id}-${replace(sa_email, "@", "-")}-on-${replace(subnet_path, "/", "_")}"
        }
      ]
    ]
  ])

  # Create the final map for the for_each argument in the IAM resource
  subnet_iam_member_map = {
    for binding in local.subnet_sharing_bindings : binding.binding_key => binding
  }
}

resource "google_compute_subnetwork_iam_member" "service_project_subnet_access" {
  for_each = local.subnet_iam_member_map

  project    = split("/", each.value.subnet_path)[1]
  region     = split("/", each.value.subnet_path)[3]
  subnetwork = split("/", each.value.subnet_path)[5]

  role   = "roles/compute.networkUser"
  member = "serviceAccount:${each.value.custom_sa_email}"

  depends_on = [
    google_compute_shared_vpc_service_project.service_project_attachment,
    module.svc_project_networking,
  ]
}