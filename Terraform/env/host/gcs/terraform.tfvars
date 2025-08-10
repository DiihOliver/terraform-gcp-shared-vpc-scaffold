/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

project_id = "<host-project-id>"

/******************************************
  GCS Bucket Details
 *****************************************/
gcs_bucket = {
  bucket_01 = {
    app_name           = "host-tf-state-us-central1-gcs"
    location           = "us-central1"
    versioning         = true
    storage_class      = "STANDARD"
    bucket_policy_only = true
    force_destroy      = false
    enable_neg         = false
    data_locations     = []
    labels = {
      environment = "mgmt-project"
      purpose     = "tf-state"
      region      = "us-central1"
    }
    retention_policy = null
  }
}
