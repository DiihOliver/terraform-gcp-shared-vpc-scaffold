/******************************************
  Providers Variables
 *****************************************/

variable "project_id" {
  description = "Existing Base project"
  type        = string
}

/******************************************
        Service API variables
 *****************************************/

variable "service_account_terraform" {
  type = object({
    service_account = string
    role_name       = optional(string)
    permissions     = optional(list(string))
  })
  description = "service Account to add the IAM policies/bindings for Terraform Deployment"
}
