terraform {
  required_version = "~> 1.14"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 8.0"
    }
  }
}

variable "environment" {
  type        = string
  description = "environment where deploy the bastion"
}

variable "compartment_id" {
  type        = string
  description = "compartment ocid contains the bastion"
}

variable "tags" {
  type        = object({ freeformTags = map(string), definedTags = map(string) })
  default     = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
  description = "common tags"
}

variable "subnet_id" {
  type        = string
  description = "bastion subnet ocid"
}

variable "bastion_name" {
  type        = string
  default     = "bastion-0"
  description = "name of the bastion display in console"
}

variable "bastion_type" {
  type        = string
  default     = "STANDARD"
  description = "the bastion type."
}

variable "dns_proxy_status" {
  type     = bool
  nullable = true
  default  = null
}

variable "max_session_ttl_in_seconds" {
  type    = number
  default = 3600
}

variable "client_cidr_block_allow_list" {
  type    = list(string)
  default = ["0.0.0.0/0"]
  validation {
    condition     = alltrue([for cidr in var.client_cidr_block_allow_list : can(cidrhost(cidr, 32))])
    error_message = "Must be valid IPv4 CIDR."
  }
}