data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

resource "oci_mysql_mysql_db_system" "mysql_db_system" {
  display_name            = var.display_name
  description             = var.description
  compartment_id          = var.compartment_ocid
  availability_domain     = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
  is_highly_available     = var.is_highly_available
  shape_name              = var.shape_name
  subnet_id               = var.subnet_id
  data_storage_size_in_gb = var.data_storage_size_in_gb

  data_storage {
    is_auto_expand_storage_enabled = var.is_auto_expand_storage_enabled
    max_storage_size_in_gbs        = var.max_storage_size_in_gbs
  }

  backup_policy {
    is_enabled        = var.backup_policy.is_enabled
    retention_in_days = var.backup_policy.retention_in_days
    window_start_time = var.backup_policy.window_start_time
  }

  maintenance {
    window_start_time = var.maintenance_window_start_time
  }
}