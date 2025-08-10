project_id = "<host-project-id>"
region     = "us-central1"

firewall_rules = [
  {
    network       = "dev-main-vpc-01"
    name          = "dev-iap-tcp-22-allow-rule"
    protocol      = "tcp"
    ports         = ["22"]
    source_ranges = ["35.235.240.0/20"]
    source_tags   = []
    target_tags   = ["allow-iap-access"]
  },
  {
    network       = "prod-main-vpc"
    name          = "prod-iap-tcp-22-allow-rule"
    protocol      = "tcp"
    ports         = ["22"]
    source_ranges = ["35.235.240.0/20"]
    source_tags   = []
    target_tags   = ["allow-iap-access"]
  }
]
