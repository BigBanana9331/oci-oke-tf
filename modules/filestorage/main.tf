terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
  }
}

data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

data "oci_kms_vaults" "vaults" {
  compartment_id = var.compartment_id
}

data "oci_kms_keys" "keys" {
  count               = var.key_name != null ? 1 : 0
  compartment_id      = var.compartment_id
  management_endpoint = [for vault in data.oci_kms_vaults.vaults.vaults : vault.management_endpoint if vault.display_name == var.vault_name][0]
}


resource "oci_file_storage_file_system" "test_file_system" {
  compartment_id      = var.compartment_id
  display_name        = var.file_system_name
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
  kms_key_id          = var.key_name != null ? [for key in data.oci_kms_keys.keys[0].keys : key.id if key.display_name == var.key_name][0] : null
}