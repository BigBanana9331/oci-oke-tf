variable "tenancy_ocid" {}

variable "compartment_ocid" {
}

variable "subnet_id" {
  type = string
}

variable "shape_name" {
  type = string
}

variable "display_name" {
  type    = string
  default = "HeatWave-DBSystem"
}

variable "description" {
  type    = string
  default = "MySQL Database Service"
}

variable "data_storage_size_in_gb" {
  type = string
}

variable "max_storage_size_in_gbs" {
  type     = string
  nullable = true
  default  = null
}

variable "is_auto_expand_storage_enabled" {
  type    = bool
  default = false
}

variable "max_storage_size_in_gbs" {
  type    = string
  default = "4000"
}

variable "is_highly_available" {
  type    = bool
  default = false
}

variable "backup_policy" {
  type = object({
    is_enabled        = string
    retention_in_days = string
    window_start_time = string
  })
  default = {
    is_enabled        = "false"
    retention_in_days = "7"
    window_start_time = "01:00-00:00"
  }
}

variable "maintenance_window_start_time" {
  type    = string
  default = "sun 01:00"
}