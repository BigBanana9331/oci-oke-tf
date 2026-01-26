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

variable "bastion_name" {
  type    = string
  default = "dev-bastion"
}

variable "bastion_type" {
  type    = string
  default = "standard"
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
}