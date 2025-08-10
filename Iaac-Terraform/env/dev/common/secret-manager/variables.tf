/****************************************/
# Secret Manager variables
/****************************************/

variable "secret_manager" {
  description = "The details of the Secret Manager."
  type = map(object({
    id     = string,
    labels = map(string)

  }))
  default = {
    secret_manager = {
      id     = ""
      labels = {}
    }
  }
}

variable "project_id" {
  description = "The project ID to manage the Secret Manager resources"
  type        = string
}

