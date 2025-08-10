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

variable "project_id" {
  description = "GCP Project ID in which the resource will be provisioned."
  type        = string
  default     = ""
}

/******************************************
   Variables for GCS Bucket
  *****************************************/


variable "gcs_bucket" {
  description = "The details of the Cloud Storage Buckets."
  type = map(object({
    app_name           = string,
    location           = string,
    versioning         = bool,
    storage_class      = string,
    bucket_policy_only = bool,
    force_destroy      = bool,
    enable_neg         = bool,
    neg_default_port   = optional(string),
    port               = optional(string),
    labels             = map(string),
    data_locations     = list(string),
    retention_policy = object({
      is_locked        = bool
      retention_period = number
    })
  }))
}
