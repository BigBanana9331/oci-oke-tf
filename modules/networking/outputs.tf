# =============================================================================
# Networking Module Outputs
# =============================================================================

output "nsgs" {
  description = "Map of NSG names to their OCIDs"
  value       = local.nsgs
}

output "route_tables" {
  description = "Map of route table names to their OCIDs"
  value       = local.route_tables
}

output "seclist" {
  description = "Map of security list names to their OCIDs"
  value       = local.seclists
}

output "services" {
  description = "Available OCI services for service gateway configuration"
  value       = data.oci_core_services.services.services
}

output "subnets" {
  description = "Map of subnet names to their OCIDs"
  value       = local.subnets
}

output "vcn_id" {
  description = "OCID of the created VCN"
  value       = oci_core_vcn.vcn.id
}
