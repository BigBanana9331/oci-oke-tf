# OCI Tag Module

Terraform module for creating and managing OCI Tag Namespaces and Tags.

## Features

- Tag namespace creation
- Defined tags with validators
- Tag defaults for compartments
- Cost tracking tags
- Resource organization

## Usage

```hcl
module "tag" {
  source = "./modules/tag"

  compartment_id = var.compartment_ocid

  tag_namespaces = {
    "CostCenter" = {
      description = "Cost center tracking"
      tags = {
        "Department" = {
          description = "Department name"
          is_cost_tracking = true
        }
        "Project" = {
          description = "Project name"
          is_cost_tracking = true
        }
      }
    }
    "Operations" = {
      description = "Operational tags"
      tags = {
        "Environment" = {
          description = "Environment (dev/staging/prod)"
          validator = {
            type   = "ENUM"
            values = ["dev", "staging", "prod"]
          }
        }
      }
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

- `oci_identity_tag_namespace` - Tag Namespaces
- `oci_identity_tag` - Tags
- `oci_identity_tag_default` - Tag Defaults

## License

Apache 2.0
