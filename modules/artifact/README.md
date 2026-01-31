# OCI Artifact Registry Module

Terraform module for creating and managing OCI Artifact Registry (Container Registry).

## Features

- Container repository creation
- Public/private repository settings
- Image retention policies
- Vulnerability scanning configuration
- Resource tagging support

## Usage

```hcl
module "artifact" {
  source = "./modules/artifact"

  compartment_id = var.compartment_ocid

  repositories = {
    "app-images" = {
      display_name = "app-images"
      is_public    = false
      is_immutable = false
    }
    "base-images" = {
      display_name = "base-images"
      is_public    = false
      is_immutable = true
    }
  }

  tags = {
    freeformTags = { "Environment" = "dev" }
    definedTags  = {}
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

- `oci_artifacts_container_repository` - Container Repositories

## License

Apache 2.0
