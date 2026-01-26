terraform {
  required_version = ">= 1.5.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
  }
}

resource "oci_identity_tag_namespace" "namespace" {
  compartment_id = var.compartment_id
  name           = var.namespace.name
  description    = var.namespace.description
  is_retired     = var.namespace.is_retired

  # tags
  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}

resource "oci_identity_tag" "tags" {
  for_each         = var.namespace.tags
  tag_namespace_id = oci_identity_tag_namespace.namespace.id
  name             = each.key
  description      = each.value.description
  is_cost_tracking = each.value.is_cost_tracking
  is_retired       = each.value.is_retired

  # tags
  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}