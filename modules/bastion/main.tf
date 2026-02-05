resource "oci_bastion_bastion" "bastion" {
  compartment_id               = var.compartment_id
  name                         = join("-", [var.environment, var.bastion_name])
  bastion_type                 = var.bastion_type
  target_subnet_id             = var.subnet_id
  dns_proxy_status             = var.dns_proxy_status
  max_session_ttl_in_seconds   = var.max_session_ttl_in_seconds
  client_cidr_block_allow_list = var.client_cidr_block_allow_list

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}