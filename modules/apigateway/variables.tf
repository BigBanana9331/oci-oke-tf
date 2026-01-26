variable "compartment_id" {
  type = string
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
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
}

variable "ip_mode" {
  type    = string
  default = "IPV4"
}

variable "nsg_names" {
  type    = set(string)
  default = ["dev-nsg-apigateway"]
}