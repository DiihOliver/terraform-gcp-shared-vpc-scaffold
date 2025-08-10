project_id = "<service-project-id>"
secret_manager = {
  secret_manager_001 = {
    id = "dev-db-secrets"
    labels = {
      env    = "dev"
      region = "us-central1"
    }
  },
  secret_manager_002 = {
    id = "app-01-secrets"
    labels = {
      env    = "dev"
      region = "us-central1"
    }
  },
  secret_manager_003 = {
    id = "app-02-secrets"
    labels = {
      env    = "dev"
      region = "us-central1"
    }
  },
  secret_manager_003 = {
    id = "app-03-secrets"
    labels = {
      env    = "dev"
      region = "us-central1"
    }
  },
}