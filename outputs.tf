# =============================================================================
# Root Module Outputs
# =============================================================================
# These outputs expose key resource IDs for use in other Terraform configurations
# or for reference in CI/CD pipelines and documentation.

# -----------------------------------------------------------------------------
# VCN Outputs
# -----------------------------------------------------------------------------

output "vcn_ids" {
  description = "Map of VCN names to their OCIDs"
  value       = { for k, v in module.vcn : k => v.vcn_id }
}

output "subnet_ids" {
  description = "Map of VCN names to their subnet ID mappings"
  value       = { for k, v in module.vcn : k => v.subnets }
}

output "nsg_ids" {
  description = "Map of VCN names to their NSG ID mappings"
  value       = { for k, v in module.vcn : k => v.nsgs }
}

output "route_table_ids" {
  description = "Map of VCN names to their route table ID mappings"
  value       = { for k, v in module.vcn : k => v.route_tables }
}

# -----------------------------------------------------------------------------
# OCI Services Data
# -----------------------------------------------------------------------------

output "oci_services" {
  description = "Available OCI services in the region (useful for service gateway configuration)"
  value       = { for k, v in module.vcn : k => v.services }
}

# -----------------------------------------------------------------------------
# Environment Information
# -----------------------------------------------------------------------------

output "environment" {
  description = "Current deployment environment"
  value       = var.environment
}

output "region" {
  description = "OCI region where resources are deployed"
  value       = var.region
}

output "app_name" {
  description = "Application name used in resource naming"
  value       = var.app_name
}
