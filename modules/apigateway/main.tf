data "oci_core_vcns" "vcns" {
  compartment_id = var.compartment_id
  display_name   = join("-", [var.environment, var.app_name, var.vcn_name])
}

data "oci_core_subnets" "subnets" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
  display_name   = join("-", [var.environment, var.app_name, var.subnet_name])
}

data "oci_core_network_security_groups" "network_security_groups" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcns.vcns.virtual_networks[0].id
  filter {
    name   = "display_name"
    values = [for nsg_name in var.nsg_names : join("-", [var.environment, var.app_name, nsg_name])]
  }
}

resource "oci_apigateway_gateway" "gateway" {
  compartment_id             = var.compartment_id
  display_name               = var.gateway_name
  endpoint_type              = var.endpoint_type
  subnet_id                  = data.oci_core_subnets.subnets.subnets[0].id
  network_security_group_ids = [for nsg in data.oci_core_network_security_groups.network_security_groups.network_security_groups : nsg.id]

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}