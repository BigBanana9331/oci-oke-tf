# OCI Private Endpoint Module

Terraform module for creating and managing OCI Private Endpoints.

## Features

- Private endpoint creation for OCI services
- VCN and subnet integration
- DNS configuration
- NSG association
- Resource tagging support

## Usage

```hcl
module "privateendpoint" {
  source = "./modules/privateendpoint"

  compartment_id = var.compartment_ocid

  private_endpoints = {
    "adb-pe" = {
      display_name = "adb-private-endpoint"
      subnet_id    = module.networking.subnets["db-subnet"]
      nsg_ids      = [module.networking.nsgs["db-nsg"]]
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

- Private Endpoint resources

## License

Apache 2.0
