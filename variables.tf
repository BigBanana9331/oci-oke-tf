variable "config_file_profile" {
  type    = string
}

variable "region" {
  type = string
}

variable "tenancy_ocid" {
  type = string
}

variable "compartment_ocid" {
  type = string
}

variable "environment" {
  type = string
}

variable "app_name" {
  type    = string
  default = "helloapp"
}

variable "tags" {
  type = object({ freeformTags = map(string), definedTags = map(string) })
  default = {
    "definedTags" = {},
    "freeformTags" = {
      "CreatedBy" = "Terraform"
    }
  }
}

variable "bastion" {
  nullable = true
  default  = null
  type = object({
    compartment_id               = string
    vcn_name                     = string
    subnet_name                  = string
    bastion_name                 = string
    bastion_type                 = string
    dns_proxy_status             = bool
    max_session_ttl_in_seconds   = number
    client_cidr_block_allow_list = list(string)
    tags                         = object({ freeformTags = map(string), definedTags = map(string) })
  })
}