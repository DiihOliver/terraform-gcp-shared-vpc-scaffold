data "google_project" "project" {
  project_id = var.project_id
}

resource "google_iam_workload_identity_pool" "github_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "github"
  display_name              = var.pool_display_name
  description               = "Identity pool for GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "Provider for Github Actions"
  oidc {
      issuer_uri = "https://token.actions.githubusercontent.com"
    }
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_owner}'"
}

# resource "google_service_account_iam_member" "impersonate_binding" {
#   service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
#   role               = "roles/iam.workloadIdentityUser"
#   member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/attribute.repository_owner/${var.github_owner}"
# }


resource "google_iam_workload_identity_pool" "jenkins_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "jenkins-pool"
  display_name              = var.jenkins_pool_display_name
  description               = "jenkins-pool"
}

resource "google_iam_workload_identity_pool_provider" "jenkins_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.jenkins_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "jenkins-aws-provider"
  # display_name                       = "Provider for Jenkins pipeline"

  aws {
    account_id = var.aws_account_id 
  }

  attribute_mapping = {
    "google.subject"             = "assertion.arn"
    "attribute.account"          = "assertion.account"
    "attribute.aws_role"         = "assertion.arn.extract('assumed-role/{role}/')"
    "attribute.aws_ec2_instance" = "assertion.arn.extract('assumed-role/{role_and_session}').extract('/{session}')" 
  }

  attribute_condition = "assertion.arn.startsWith('arn:aws:sts::${var.aws_account_id}:assumed-role/')"
}
