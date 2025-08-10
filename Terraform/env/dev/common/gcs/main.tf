/******************************************
  Storage Bucket Details
 *****************************************/

module "gcs_bucket" {
  source             = "../../../../modules/cloud_storage"
  project_id         = var.project_id
  for_each           = var.gcs_bucket
  name               = each.value.app_name
  location           = each.value.location
  enable_neg         = each.value.enable_neg
  data_locations     = each.value.data_locations
  versioning         = each.value.versioning
  storage_class      = each.value.storage_class
  bucket_policy_only = each.value.bucket_policy_only
  force_destroy      = each.value.force_destroy
  labels             = each.value.labels
  retention_policy   = each.value.retention_policy
  iam_members        = each.value.iam_members
}