# OCI Manifest Module

Terraform module for managing Kubernetes manifests on OKE clusters.

## Features

- Kubernetes manifest deployment
- ConfigMap and Secret management
- Namespace creation
- Integration with OKE clusters
- YAML file processing

## Usage

```hcl
module "manifest" {
  source = "./modules/manifest"

  cluster_id = module.container.cluster_id

  namespaces = ["app", "monitoring", "logging"]

  manifests = {
    "app-config" = {
      yaml_body = file("${path.module}/manifests/app-config.yaml")
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7 |
| oci | ~> 7.30 |
| kubernetes | ~> 2.0 |

## Inputs

See [variables.tf](variables.tf) for the complete list of input variables.

## Outputs

See [outputs.tf](outputs.tf) for the complete list of outputs.

## Resources Created

- Kubernetes namespaces
- Kubernetes manifests

## License

Apache 2.0
