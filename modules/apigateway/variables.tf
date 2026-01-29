terraform {
  required_version = ">= 1.5.7"
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

variable "compartment_id" {
  type = string
}

variable "vcn_name" {
  type    = string
  default = "dev-vcn"
}

variable "subnet_name" {
  type    = string
  default = "dev-subnet-bastion"
}

variable "gateway_name" {
  type    = string
  default = "dev-apigateway"
}

variable "endpoint_type" {
  type    = string
  default = "PRIVATE"
  validation {
    condition     = contains(["PRIVATE", "PUBLIC"], var.endpoint_type)
    error_message = "endpoint_type must be PRIVATE or PUBLIC"
  }
}

variable "ip_mode" {
  type    = string
  default = "IPV4"
  validation {
    condition     = contains(["IPV4", "IPV6", "DUAL_STACK"], var.ip_mode)
    error_message = "endpoint_type must be IPV4 or IPV6 or DUAL_STACK"
  }
}

variable "nsg_names" {
  type    = set(string)
  default = ["dev-nsg-apigateway"]
}