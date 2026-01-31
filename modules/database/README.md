# OCI Database Module

Terraform module for creating and managing OCI Autonomous Database instances.

## Features

- Autonomous Database provisioning
- Vault integration for admin password
- VCN integration with private endpoints
- Configurable compute and storage
- MTLS and TLS connection options
- Backup and restore configuration

## Usage

```hcl
module "database" {
  source = "./modules/database"

  tenancy_ocid   = var.tenancy_ocid
  compartment_id = var.compartment_ocid

  vcn_name                   = "dev-myapp-main"
  vault_name                 = "myapp-vault"
  admin_password_secret_name = "db-admin-password"

  databases = {
    "myapp-db" = {
      db_workload                    = "OLTP"
      db_name                        = "myappdb"
      cpu_core_count                 = 1
      data_storage_size_in_tbs       = 1
      is_auto_scaling_enabled        = true
      is_mtls_connection_required    = true
      nsg_display_name               = "db-nsg"
      private_endpoint_subnet_name   = "db-subnet"
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

- `oci_database_autonomous_database` - Autonomous Database
- `oci_identity_policy` - IAM Policies for Vault access

## License

Apache 2.0
