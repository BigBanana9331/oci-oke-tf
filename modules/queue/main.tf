terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
  }
}


# data "oci_kms_vaults" "vaults" {
#   compartment_id = var.compartment_id
# }

# data "oci_kms_keys" "keys" {
#   count               = var.key_name != null ? 1 : 0
#   compartment_id      = var.compartment_id
#   management_endpoint = [for vault in data.oci_kms_vaults.vaults.vaults : vault.management_endpoint if vault.display_name == var.vault_name][0]
# }

resource "oci_queue_queue" "queue" {
  #Required
  compartment_id = var.compartment_id
  display_name   = var.queue_name

  #Optional
  channel_consumption_limit = var.queue_channel_consumption_limit
  # custom_encryption_key_id         = var.key_name != null ? [for key in data.oci_kms_keys.keys[0].keys : key.id if key.display_name == var.key_name][0] : null
  dead_letter_queue_delivery_count = var.queue_dead_letter_queue_delivery_count
  purge_trigger                    = var.purge_trigger
  purge_type                       = var.purge_type
  retention_in_seconds             = var.queue_retention_in_seconds
  timeout_in_seconds               = var.queue_timeout_in_seconds
  visibility_in_seconds            = var.queue_visibility_in_seconds

  # tags
  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}