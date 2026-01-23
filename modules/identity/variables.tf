variable "compartment_id" {}

variable "namespace" {
  type = object({
    name        = string
    description = optional(string)
    is_retired  = optional(bool, false)
    tags = map(object({
      description      = optional(string)
      is_cost_tracking = optional(bool, false)
      is_retired       = optional(bool, false)
    }))
  })

  default = {
    name        = "AutoTagging"
    description = "Automation tag namespace when create resource"
    tags = {
      "AppName" = {
        description = "Managed Application Name"
      }
      "CreatedBy" = {
        description = "Which create reources"
      }
    }
  }
}

variable "freeform_tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
    "ManagedBy" = "InfraTeam"
  }
}
