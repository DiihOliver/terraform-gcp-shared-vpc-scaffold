resource "google_project_iam_member" "project_iam_member" {
  for_each = toset(var.project_roles)
  project  = var.project
  role     = each.key
  member   = "serviceAccount:${var.service_account_address}"
}
