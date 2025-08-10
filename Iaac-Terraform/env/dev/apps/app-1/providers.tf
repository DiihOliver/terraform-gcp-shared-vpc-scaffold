provider "google" {}

data "google_secret_manager_secret_version" "cloudflare_api_token" {
  secret  = var.cloudflare_api_token_secret_name
  project = var.service_project_id
  version = "latest"
}

provider "cloudflare" {
  api_token = data.google_secret_manager_secret_version.cloudflare_api_token.secret_data
}