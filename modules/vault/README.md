# OCI Vault Module

Terraform module for creating and managing OCI Vault and KMS encryption keys.

## Features

- OCI Vault creation with configurable vault type
- Master encryption keys with configurable algorithms
- Auto-rotation support for keys
- Secret management integration
- Resource tagging support

## Usage

```hcl
module "vault" {
  source = "./modules/vault"

  compartment_id = var.compartment_ocid
  vault_name     = "myapp-vault"
  vault_type     = "DEFAULT"

  tags = {
    freeformTags = { "Environment" = "dev" }
    definedTags  = {}
  }

  master_keys = {
    "database-key" = {
      algorithm                = "AES"
      length                   = 32
      protection_mode          = "SOFTWARE"
      is_auto_rotation_enabled = true
      rotation_interval_in_days = 90
    }
    "storage-key" = {
      algorithm                = "AES"
      length                   = 32
      protection_mode          = "SOFTWARE"
      is_auto_rotation_enabled = false
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

- `oci_kms_vault` - KMS Vault
- `oci_kms_key` - Master Encryption Keys

## License

Apache 2.0
