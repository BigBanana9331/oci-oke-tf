terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.31.0"
    }
  }
}

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
