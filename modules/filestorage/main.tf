data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

data "oci_kms_vaults" "vaults" {
  compartment_id = var.compartment_id
  filter {
    name   = "display_name"
    values = [var.vault_name]
  }
}

data "oci_kms_keys" "keys" {
  count               = var.key_name != null ? 1 : 0
  compartment_id      = var.compartment_id
  management_endpoint = data.oci_kms_vaults.vaults.vaults[0].management_endpoint
  filter {
    name   = "display_name"
    values = [var.key_name]
  }
}


resource "oci_file_storage_file_system" "test_file_system" {
  compartment_id      = var.compartment_id
  display_name        = var.file_system_name
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
  kms_key_id          = var.key_name != null && length(data.oci_kms_keys.keys) > 0 ? data.oci_kms_keys.keys.keys[0].id : null

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}