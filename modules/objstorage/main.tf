terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
  }
}


data "oci_objectstorage_namespace" "namespace" {
  compartment_id = var.compartment_id
}

# data "oci_kms_vaults" "vaults" {
#   compartment_id = var.compartment_id
# }

# data "oci_kms_keys" "keys" {
#   count               = var.key_name != null ? 1 : 0
#   compartment_id      = var.compartment_id
#   management_endpoint = [for vault in data.oci_kms_vaults.vaults.vaults : vault.management_endpoint if vault.display_name == var.vault_name][0]
# }

resource "oci_objectstorage_bucket" "bucket" {
  for_each       = var.buckets
  compartment_id = var.compartment_id
  name           = each.value
  namespace      = data.oci_objectstorage_namespace.namespace.namespace
  # kms_key_id     = var.key_name != null ? [for key in data.oci_kms_keys.keys[0].keys : key.id if key.display_name == var.key_name][0] : null

  # tags
  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}