resource "oci_mysql_mysql_db_system" "mysql_db_system" {
  compartment_id      = var.compartment_id
  availability_domain = var.availability_domain
  display_name        = join("-", [var.environment, var.display_name])
  description         = var.description

  is_highly_available     = var.is_highly_available
  shape_name              = var.shape_name
  data_storage_size_in_gb = var.data_storage_size_in_gb
  admin_username          = var.admin_username
  admin_password          = var.admin_password

  subnet_id = var.subnet_id
  nsg_ids   = var.nsg_ids

  mysql_version       = var.mysql_version
  access_mode         = var.access_mode
  database_mode       = var.database_mode
  crash_recovery      = var.crash_recovery
  database_management = var.database_management
  port                = var.port
  port_x              = var.port_x
  ip_address          = var.ip_address
  # hostname_label      = join("-", [var.environment, var.hostname_label])
  hostname_label = join("-", [var.environment, var.display_name])

  dynamic "encrypt_data" {
    for_each = var.key_generation_type != null ? [1] : []
    content {
      key_generation_type = var.key_generation_type
      key_id              = var.key_generation_type == "BYOK" ? var.kms_key_id : null
    }
  }

  dynamic "secure_connections" {
    for_each = var.certificate_generation_type != null ? [1] : []
    content {
      certificate_generation_type = var.certificate_generation_type
      certificate_id              = var.certificate_id
    }
  }

  dynamic "data_storage" {
    for_each = var.data_storage != null ? [1] : []
    content {
      is_auto_expand_storage_enabled = var.data_storage.is_auto_expand_storage_enabled
      max_storage_size_in_gbs        = var.data_storage.max_storage_size_in_gbs
    }
  }

  dynamic "backup_policy" {
    for_each = var.backup_policy != null ? [1] : []
    content {
      defined_tags      = var.tags.definedTags
      freeform_tags     = var.tags.freeformTags
      is_enabled        = var.backup_policy.is_enabled
      retention_in_days = var.backup_policy.retention_in_days
      window_start_time = var.backup_policy.window_start_time
      soft_delete       = var.backup_policy.soft_delete
      dynamic "pitr_policy" {
        for_each = var.backup_policy.pitr_enabled != null ? [1] : []
        content {
          is_enabled = var.backup_policy.pitr_enabled
        }
      }
    }
  }

  dynamic "deletion_policy" {
    for_each = var.deletion_policy != null ? [1] : []
    content {
      automatic_backup_retention = var.deletion_policy.automatic_backup_retention
      final_backup               = var.deletion_policy.final_backup
      is_delete_protected        = var.deletion_policy.is_delete_protected
    }
  }

  dynamic "read_endpoint" {
    for_each = var.read_endpoint != null ? [1] : []
    content {
      exclude_ips                  = var.read_endpoint.exclude_ips
      is_enabled                   = var.read_endpoint.is_enabled
      read_endpoint_hostname_label = var.read_endpoint.hostname_label
      read_endpoint_ip_address     = var.read_endpoint.ip_address
    }
  }

  dynamic "rest" {
    for_each = var.rest != null ? [1] : []
    content {
      configuration = var.rest.configuration
      port          = var.rest.port
    }
  }

  dynamic "database_console" {
    for_each = var.database_console != null ? [1] : []
    content {
      status = var.database_console.status
      port   = var.database_console.port
    }
  }
  dynamic "maintenance" {
    for_each = var.maintenance != null ? [1] : []
    content {
      window_start_time         = var.maintenance.window_start_time
      maintenance_schedule_type = var.maintenance.maintenance_schedule_type
      version_preference        = var.maintenance.version_preference
      version_track_preference  = var.maintenance.version_track_preference
    }
  }

  defined_tags  = var.tags.definedTags
  freeform_tags = var.tags.freeformTags

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }
}