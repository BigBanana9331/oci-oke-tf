variable "compartment_id" {
  type = string
}

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
    name        = "Governance"
    description = "Automation tag namespace when create resource"
    tags = {
      "AppName" = {
        description = "Managed Application Name"
      }
    }
  }
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
}
