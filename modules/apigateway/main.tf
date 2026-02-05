resource "oci_apigateway_gateway" "gateway" {
  compartment_id             = var.compartment_id
  display_name               = join("-", [var.environment, var.gateway_name])
  endpoint_type              = var.endpoint_type
  subnet_id                  = var.subnet_id
  network_security_group_ids = var.nsg_ids

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}