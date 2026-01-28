output "cluster_id" {
  value = oci_containerengine_cluster.cluster.id
}

output "endpoints" {
  value = oci_containerengine_cluster.cluster.endpoints
}