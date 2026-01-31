# OCI Queue Module

Terraform module for creating and managing OCI Queue service resources.

## Features

- Queue creation with configurable settings
- Dead letter queue configuration
- Message retention policies
- Visibility timeout configuration
- Resource tagging support

## Usage

```hcl
module "queue" {
  source = "./modules/queue"

  compartment_id = var.compartment_ocid

  queues = {
    "order-queue" = {
      display_name                  = "order-processing-queue"
      retention_in_seconds          = 86400
      visibility_in_seconds         = 30
      dead_letter_queue_delivery_count = 5
    }
    "notification-queue" = {
      display_name         = "notification-queue"
      retention_in_seconds = 3600
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

- `oci_queue_queue` - Queues

## License

Apache 2.0
