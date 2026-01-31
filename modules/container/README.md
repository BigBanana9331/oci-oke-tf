# OCI Container (OKE) Module

Terraform module for creating and managing Oracle Container Engine for Kubernetes (OKE) clusters.

## Features

- OKE cluster with configurable Kubernetes version
- Node pools with flexible compute shapes
- Integration with VCN networking
- Logging integration
- Support for GPU and non-GPU nodes
- Cluster autoscaling support

## Usage

```hcl
module "container" {
  source = "./modules/container"

  tenancy_ocid   = var.tenancy_ocid
  compartment_id = var.compartment_ocid
  environment    = "dev"
  app_name       = "myapp"

  cluster_name       = "oke-cluster"
  kubernetes_version = "v1.28.2"
  cluster_type       = "ENHANCED_CLUSTER"

  vcn_name       = "main"
  log_group_name = "oke-logs"

  node_pools = {
    "worker-pool" = {
      node_shape = "VM.Standard.E4.Flex"
      size       = 3
      memory     = 16
      ocpus      = 2
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7 |
| oci | ~> 7.30 |

## Inputs

See [variables.tf](variables.tf) for the complete list of input variables.

## Outputs

See [outputs.tf](outputs.tf) for the complete list of outputs.

## Resources Created

- `oci_containerengine_cluster` - OKE Cluster
- `oci_containerengine_node_pool` - Node Pools

## License

Apache 2.0
