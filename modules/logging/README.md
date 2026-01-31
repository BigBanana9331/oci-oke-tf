# OCI Logging Module

Terraform module for creating and managing OCI Logging service resources.

## Features

- Log groups for organizing logs
- Custom logs with configurable retention
- Service logs integration
- Log analytics integration
- Resource tagging support

## Usage

```hcl
module "logging" {
  source = "./modules/logging"

  compartment_id = var.compartment_ocid
  environment    = "dev"
  app_name       = "myapp"

  log_groups = {
    "app-logs" = {
      description = "Application logs"
    }
    "audit-logs" = {
      description = "Audit logs"
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

- `oci_logging_log_group` - Log Groups
- `oci_logging_log` - Logs

## License

Apache 2.0
