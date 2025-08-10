project_id = ""

gcs_bucket = {
  prod-eu-tf-state-eu-west3-gcs = {
    app_name           = "prod-eu-tf-state-eu-west3-gcs"
    location           = "europe-west3"
    versioning         = true
    storage_class      = "STANDARD"
    bucket_policy_only = true
    force_destroy      = false
    enable_neg         = false
    data_locations     = []
    labels = {
      environment = "prod-eu"
      purpose     = "state-file"
      region      = "europe-west3"
    }
    retention_policy = null
  }
  prod-pgsql-dump-eu-west3-gcs = {
    app_name           = "prod-pgsql-dump-eu-west3-gcs"
    location           = "europe-west3"
    versioning         = true
    storage_class      = "STANDARD"
    bucket_policy_only = true
    force_destroy      = false
    enable_neg         = false
    data_locations     = []
    labels = {
      environment = "prod-eu"
      purpose     = "pgsql-dump"
      region      = "europe-west3"
    }
    retention_policy = null
  }
}
