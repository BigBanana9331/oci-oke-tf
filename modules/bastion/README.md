# OCI Bastion Module

Terraform module for creating and managing OCI Bastion service for secure access to resources.

## Features

- Managed Bastion service
- SSH session management
- Port forwarding sessions
- CIDR-based access control
- Session time limits
- Integration with VCN subnets

## Usage

```hcl
module "bastion" {
  source = "./modules/bastion"

  compartment_id = var.compartment_ocid
  environment    = "dev"
  app_name       = "myapp"

  bastion_name = "secure-bastion"
  target_subnet_id = module.networking.subnets["app-subnet"]
  
  client_cidr_block_allow_list = ["10.0.0.0/8"]
  max_session_ttl_in_seconds   = 3600

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

- `oci_bastion_bastion` - Bastion Service

## License

Apache 2.0
