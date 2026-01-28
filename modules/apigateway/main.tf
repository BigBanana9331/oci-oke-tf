data "oci_core_vcns" "vcns" {
  compartment_id = var.compartment_id
  display_name   = var.vcn_name
}

data "oci_core_subnets" "subnets" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
}

data "oci_core_network_security_groups" "network_security_groups" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
}

resource "oci_apigateway_gateway" "gateway" {
  compartment_id = var.compartment_id
  display_name   = var.gateway_name
  endpoint_type  = var.endpoint_type
  ip_mode        = var.ip_mode
  subnet_id      = [for subnet in data.oci_core_subnets.subnets.subnets : subnet.id if subnet.display_name == var.subnet_name][0]
  network_security_group_ids = flatten([for nsg in data.oci_core_network_security_groups.network_security_groups.network_security_groups :
  [for nsg_name in var.nsg_names : nsg.id if nsg.display_name == nsg_name]])

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}