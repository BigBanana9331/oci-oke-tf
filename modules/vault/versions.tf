terraform {
  required_version = ">= 1.7"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.30"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}
