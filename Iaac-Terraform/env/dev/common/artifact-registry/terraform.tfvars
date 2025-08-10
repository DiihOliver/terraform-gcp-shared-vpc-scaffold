/******************************************
  Details of COMMON Artifact Repository
 *****************************************/

project_id = "<service-project-id>"

repo = {
  repo_01 = {
    repo_name   = "dev-us-central1-app-images-gar"
    region      = "us-central1"
    format      = "DOCKER"
    description = "For Docker Images"
    labels = {
      environment = "dev",
      purpose     = "base-image",
      region      = "us-central1"
    }
    immutable_tags = false,
    cleanup_policies = {
      "policy_1" = {
        action = "DELETE",
        condition = {
          tag_state  = "UNTAGGED",
          older_than = "7d"
        }
      },
      "policy_2" = {
        action = "DELETE",
        condition = {
          tag_state    = "TAGGED",
          tag_prefixes = ["main", "master"]
          older_than   = "30d"
        }
      },
      "policy_3" = {
        action = "KEEP",
        condition = {
          tag_state    = "TAGGED",
          tag_prefixes = ["dev", "staging", "production", "v"]
        }
      }
    }
  },
}
