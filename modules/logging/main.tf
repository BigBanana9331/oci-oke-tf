resource "oci_logging_log_group" "log_group" {
  compartment_id = var.compartment_id
  display_name   = join("-", [var.environment, var.app_name, var.log_group_name])
  description    = var.log_group_description

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}