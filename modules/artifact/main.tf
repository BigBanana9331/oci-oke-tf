resource "oci_artifacts_container_repository" "container_repository" {
  for_each       = var.registries
  compartment_id = var.compartment_id
  display_name   = each.key
  is_immutable   = each.value.is_immutable
  is_public      = each.value.is_public

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}