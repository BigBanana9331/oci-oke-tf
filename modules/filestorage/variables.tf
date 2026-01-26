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
  default  = "tuntas-key"
}

variable "file_system_name" {
  type    = string
  default = "dev-filestorage"
}