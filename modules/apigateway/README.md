# OCI API Gateway Module

Terraform module for creating and managing OCI API Gateway resources.

## Features

- API Gateway with configurable endpoints
- Route configuration
- Authentication policies (JWT, OAuth)
- Rate limiting
- CORS configuration
- Integration with backend services
- Resource tagging support

## Usage

```hcl
module "apigateway" {
  source = "./modules/apigateway"

  compartment_id = var.compartment_ocid
  environment    = "dev"
  app_name       = "myapp"

  gateway_name = "api-gateway"
  subnet_id    = module.networking.subnets["public-subnet"]
  
  deployments = {
    "v1" = {
      path_prefix = "/api/v1"
      routes = [
        {
          path    = "/users"
          methods = ["GET", "POST"]
          backend = {
            type = "ORACLE_FUNCTIONS_BACKEND"
            function_id = "ocid1.fnfunc..."
          }
        }
      ]
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

- `oci_apigateway_gateway` - API Gateway
- `oci_apigateway_deployment` - API Deployments

## License

Apache 2.0
