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

variable "buckets" {
  type    = set(string)
  default = ["dev-objectstorage-fe", "dev-objectstorage-be"]
}

variable "tags" {
  type    = object({ freeformTags = map(string), definedTags = map(string) })
  default = { "definedTags" = {}, "freeformTags" = { "CreatedBy" = "Terraform" } }
}