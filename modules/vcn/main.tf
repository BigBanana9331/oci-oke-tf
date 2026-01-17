resource "oci_core_vcn" "vcn" {
    #Required
    compartment_id = var.compartment_id
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
    dns_label = var.vcn_dns_label
}

resource "oci_core_internet_gateway" "internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id
    enabled = var.internet_gateway_enabled
    display_name = var.internet_gateway_display_name
}

resource "oci_core_nat_gateway" "nat_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id
    display_name = var.nat_gateway_display_name
}

resource "oci_core_service_gateway" "service_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id
    display_name = var.service_gateway_display_name
}