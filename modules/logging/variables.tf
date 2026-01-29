terraform {
  required_version = "~> 1.14"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.30"
    }
  }
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
}

variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "log_group_name" {
  type    = string
  default = "loggroup-0"
}

variable "log_group_description" {
  type     = string
  nullable = true
  default  = null
}
