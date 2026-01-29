module "logging" {
  source         = "./modules/logging"
  app_name       = var.app_name
  environment    = var.environment
  compartment_id = var.compartment_ocid
}

module "networking" {
  source         = "./modules/networking"
  app_name       = var.app_name
  environment    = var.environment
  compartment_id = var.compartment_ocid
}

module "bastion" {
  source         = "./modules/bastion"
  app_name       = var.app_name
  environment    = var.environment
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking]
}

module "apigateway" {
  source         = "./modules/apigateway"
  app_name       = var.app_name
  environment    = var.environment
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking]
}

module "container" {
  source         = "./modules/container"
  tenancy_ocid   = var.tenancy_ocid
  app_name       = var.app_name
  environment    = var.environment
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking, module.logging]
}