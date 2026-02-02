terraform {
  required_version = "~> 1.14"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.0"
    }
  }
  backend "oci" {}
}

provider "oci" {
  config_file_profile = var.config_file_profile
}