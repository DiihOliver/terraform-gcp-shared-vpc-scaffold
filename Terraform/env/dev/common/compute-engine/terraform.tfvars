/*****************************
  Details of Compute Engines 
 *****************************/

compute_instance = {
  compute_instance_01 = {
    machine_name            = "dev-mgmt-vm-us-central1-01"
    project_id              = "<service-project-id>"
    machine_type            = "e2-standard-2"
    region                  = "us-central1"
    enable_external_ip      = false
    generate_internal_ip    = false
    internal_ip_address     = ["10.1.0.5"]
    network                 = "projects/<host-project-id>/global/networks/dev-main-vpc-01"
    subnetwork              = "projects/<host-project-id>/regions/us-central1/subnetworks/dev-mgmt-pvt-us-central1-subnet"
    network_tags            = ["allow-iap-access"]
    instance_count          = 1
    vm_description          = "Management VM"
    machine_zone            = ["us-central1-a"]
    vm_deletion_protect     = true
    instance_image_selflink = "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20250527"
    service_account = {
      email  = "dev-mgmt-sa@<service-project-id>.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    instance_labels = {
      "purpose" = "management-vm",
      "env"     = "dev"
    }
    boot_disk0_info = {
      disk_size_gb = 50
      disk_type    = "pd-standard"
    }
  },
  compute_instance_02 = {
    machine_name            = "dev-postgress-vm-us-central1-01"
    project_id              = "<service-project-id>"
    machine_type            = "e2-medium"
    region                  = "us-central1"
    enable_external_ip      = false
    generate_internal_ip    = false
    internal_ip_address     = ["10.1.48.5"]
    network                 = "projects/<host-project-id>/global/networks/dev-main-vpc-01"
    subnetwork              = "projects/<host-project-id>/regions/us-central1/subnetworks/dev-postgres-pvt-us-central1-subnet"
    network_tags            = ["allow-iap-access"]
    instance_count          = 1
    vm_description          = "PostgreSQL VM"
    machine_zone            = ["us-central1-a"]
    vm_deletion_protect     = true
    instance_image_selflink = "projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20250527"
    service_account = {
      email  = "dev-postgre-sa@<service-project-id>.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
    instance_labels = {
      "purpose" = "postgresql-vm",
      "env"     = "dev"
    }
    boot_disk0_info = {
      disk_size_gb = 75
      disk_type    = "pd-standard"
    }
  }
}
