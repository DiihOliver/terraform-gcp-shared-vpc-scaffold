/******************************************
  service_account variables
 *****************************************/

variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "service_account_gke" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for gke"
}

variable "service_account_mgmt" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for management vm"
}

variable "service_account_wif" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for management vm"
}

variable "service_account_cr" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for Cloud Run"
}

variable "service_account_cf" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for Cloud Function"
}

variable "service_account_postgre" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for postgreSQL vm"
}

variable "service_account_terraform" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for Terraform Deployment"
}

variable "service_account_amplitude" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for amplitude migration"
}


variable "service_account_configs" {
  description = "A map of configurations for service accounts, their custom roles, and IAM bindings."
  type = map(object({
    service_account_name    = string
    project_level_roles     = list(string)
    
    # If custom_role_id is null or omitted, no custom role will be created.
    custom_role_id          = optional(string, null)
    custom_role_permissions = optional(list(string), [])
  }))
  default = {}
}