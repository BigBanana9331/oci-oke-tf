terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.31.0"
    }
  }
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
}

variable "compartment_id" {
  type = string
}

variable "registries" {
  type = map(object({
    is_immutable = optional(bool, false)
    is_public    = optional(bool, false)
  }))
  default = {
    "dev-registry" = {}
  }
}