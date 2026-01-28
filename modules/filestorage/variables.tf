terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.30"
    }
  }
}

variable "tenancy_ocid" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "vault_name" {
  type     = string
  nullable = true
  default  = "dev-vault"
}

variable "key_name" {
  type     = string
  nullable = true
  default  = "master-key"
}

variable "file_system_name" {
  type    = string
  default = "dev-filestorage"
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
}