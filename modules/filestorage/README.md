# OCI File Storage Module

Terraform module for creating and managing OCI File Storage service resources.

## Features

- File systems with configurable storage
- Mount targets for VCN access
- Export paths and export options
- Snapshot policies
- Resource tagging support

## Usage

```hcl
module "filestorage" {
  source = "./modules/filestorage"

  compartment_id      = var.compartment_ocid
  availability_domain = "AD-1"

  file_systems = {
    "shared-data" = {
      display_name = "shared-data-fs"
    }
  }

  mount_targets = {
    "mt-1" = {
      subnet_id    = module.networking.subnets["app-subnet"]
      display_name = "app-mount-target"
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

- `oci_file_storage_file_system` - File Systems
- `oci_file_storage_mount_target` - Mount Targets
- `oci_file_storage_export` - Exports

## License

Apache 2.0
