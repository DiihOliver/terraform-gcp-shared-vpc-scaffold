# /*
#  * Copyright 2022 Google LLC. 
#  * 
#  * This software is provided as-is, without warranty or representation for any use or purpose. 
#  * Your use of it is subject to your agreement with Google.
#  */
variable "neg-name" {
  description = "Name of the network endpoint group"
  type        = string
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "Region to deploy the network endpoint group"
  type        = string
}

variable "cloud_run_service_names" {
  description = "List of Cloud Run service names deployed in the project"
  type        = list(string)
  default     = []  # You can provide default values or leave it empty
}

