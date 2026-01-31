# OCI Networking Module

Terraform module for creating and managing Oracle Cloud Infrastructure (OCI) networking resources including VCN, subnets, route tables, security lists, network security groups, and gateways.

## Features

- Virtual Cloud Network (VCN) with configurable CIDR blocks
- NAT Gateway for private subnet internet access
- Service Gateway for OCI service access
- Flexible subnet configuration (public/private)
- Route tables with customizable routes
- Security lists with ingress/egress rules
- Network Security Groups (NSGs) with granular rules
- Resource tagging support (freeform and defined tags)

## Usage

```hcl
module "networking" {
  source = "./modules/networking"

  environment    = "dev"
  app_name       = "myapp"
  compartment_id = var.compartment_ocid
  vcn_name       = "main"
  cidr_blocks    = ["10.0.0.0/16"]

  tags = {
    freeformTags = { "Environment" = "dev" }
    definedTags  = {}
  }

  route_tables = {
    "private-rt" = [
      {
        network_entity_name = "natgw"
        destination         = "0.0.0.0/0"
        destination_type    = "CIDR_BLOCK"
        description         = "Route to NAT Gateway"
      },
      {
        network_entity_name = "svcgw"
        destination_type    = "SERVICE_CIDR_BLOCK"
        description         = "Route to Service Gateway"
      }
    ]
  }

  subnets = {
    "app-subnet" = {
      cidr_block                 = "10.0.1.0/24"
      prohibit_internet_ingress  = true
      prohibit_public_ip_on_vnic = true
      route_table_name           = "private-rt"
    }
    "db-subnet" = {
      cidr_block                 = "10.0.2.0/24"
      prohibit_internet_ingress  = true
      prohibit_public_ip_on_vnic = true
      route_table_name           = "private-rt"
    }
  }

  nsgs = {
    "app-nsg" = [
      {
        direction   = "INGRESS"
        protocol    = "6"
        source      = "10.0.0.0/16"
        source_type = "CIDR_BLOCK"
        description = "Allow internal traffic"
        tcp_options = {
          min = 443
          max = 443
        }
      }
    ]
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7 |
| oci | ~> 7.30 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Deployment environment (dev, staging, prod) | `string` | n/a | yes |
| app_name | Application name for resource naming | `string` | n/a | yes |
| compartment_id | OCI compartment OCID | `string` | n/a | yes |
| vcn_name | VCN display name suffix | `string` | `"vcn-0"` | no |
| cidr_blocks | List of CIDR blocks for the VCN | `list(string)` | `["10.0.0.0/16"]` | no |
| service_gateway_name | Service gateway name (null to skip) | `string` | `"sg-0"` | no |
| nat_gateway_name | NAT gateway name (null to skip) | `string` | `"ng-0"` | no |
| route_tables | Map of route table configurations | `map(set(object))` | `{}` | no |
| subnets | Map of subnet configurations | `map(object)` | `{}` | no |
| nsgs | Map of NSG configurations with rules | `map(list(object))` | `{}` | no |
| security_lists | Map of security list configurations | `map(object)` | `null` | no |
| tags | Resource tags (freeformTags, definedTags) | `object` | See variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| vcn_id | OCID of the created VCN |
| subnets | Map of subnet names to their OCIDs |
| nsgs | Map of NSG names to their OCIDs |
| route_tables | Map of route table names to their OCIDs |
| seclist | Map of security list names to their OCIDs |
| services | Available OCI services for service gateway |

## Resources Created

- `oci_core_vcn` - Virtual Cloud Network
- `oci_core_nat_gateway` - NAT Gateway (optional)
- `oci_core_service_gateway` - Service Gateway (optional)
- `oci_core_route_table` - Route Tables
- `oci_core_subnet` - Subnets
- `oci_core_network_security_group` - Network Security Groups
- `oci_core_network_security_group_security_rule` - NSG Rules
- `oci_core_security_list` - Security Lists (optional)

## Testing

```bash
# Run unit tests
terraform test tests/networking_unit_test.tftest.hcl

# Run all tests
terraform test
```

## License

Apache 2.0
