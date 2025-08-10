# /*
#  * Copyright 2022 Google LLC. 
#  * 
#  * This software is provided as-is, without warranty or representation for any use or purpose. 
#  * Your use of it is subject to your agreement with Google.
#  */

# terraform {
#   required_version = ">= 1.0"

#   required_providers {
#     google = ">= 3.16, <4.0.0"
#   }
# }

terraform {
  required_version = ">= 1.12.0"
  required_providers {
    google      = ">= 6.41.0"
  }
}