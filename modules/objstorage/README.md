# OCI Object Storage Module

Terraform module for creating and managing OCI Object Storage buckets.

## Features

- Bucket creation with configurable access types
- Versioning support
- Lifecycle policies
- Encryption with customer-managed keys
- Retention rules
- Resource tagging support

## Usage

```hcl
module "objstorage" {
  source = "./modules/objstorage"

  compartment_id = var.compartment_ocid

  buckets = {
    "app-data" = {
      access_type           = "NoPublicAccess"
      storage_tier          = "Standard"
      versioning            = "Enabled"
      auto_tiering          = "InfrequentAccess"
    }
    "backups" = {
      access_type  = "NoPublicAccess"
      storage_tier = "Archive"
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

- `oci_objectstorage_bucket` - Object Storage Buckets

## License

Apache 2.0
