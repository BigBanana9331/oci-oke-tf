module "tag" {
  source         = "./modules/tag"
  compartment_id = var.compartment_ocid
}

module "loggroup" {
  source         = "./modules/logging"
  compartment_id = var.compartment_ocid
  depends_on     = [module.tag]
}

module "networking" {
  source         = "./modules/networking"
  compartment_id = var.compartment_ocid
  depends_on     = [module.tag]
}

module "bastion" {
  source         = "./modules/bastion"
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking]
}

module "apigateway" {
  source         = "./modules/apigateway"
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking]
}

module "container" {
  source         = "./modules/container"
  tenancy_ocid   = var.tenancy_ocid
  compartment_id = var.compartment_ocid
  depends_on     = [module.networking, module.loggroup]
}