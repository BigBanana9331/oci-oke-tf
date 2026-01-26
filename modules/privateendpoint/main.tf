data "oci_core_vcns" "vcns" {
  compartment_id = var.compartment_id
  display_name   = var.private_endpoint.vcn_name
}

data "oci_core_subnets" "subnets" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
}

data "oci_core_network_security_groups" "network_security_groups" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
}

resource "oci_resourcemanager_private_endpoint" "private_endpoint" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
  subnet_id      = [for subnet in data.oci_core_subnets.subnets.subnets : subnet.id if subnet.display_name == var.private_endpoint.subnet_name][0]
  display_name   = var.private_endpoint.name
  description    = var.private_endpoint.description
  nsg_id_list = flatten([for nsg in data.oci_core_network_security_groups.network_security_groups.network_security_groups :
  [for nsg_name in var.private_endpoint.nsg_id_list : nsg.id if nsg.display_name == nsg_name]])
  dns_zones                                  = var.private_endpoint.dns_zones
  is_used_with_configuration_source_provider = var.private_endpoint.is_used_with_configuration_source_provider

  # tags
  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}