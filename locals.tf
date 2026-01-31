# =============================================================================
# Local Values
# =============================================================================
# Centralized local values for use across the root module

locals {
  # Standard naming prefix for all resources
  name_prefix = "${var.environment}-${var.app_name}"

  # Common tags to be applied to all resources
  common_tags = {
    freeformTags = merge(
      var.tags.freeformTags,
      {
        Environment = var.environment
        Application = var.app_name
        ManagedBy   = "Terraform"
      }
    )
    definedTags = var.tags.definedTags
  }

  # Timestamp for unique resource naming when needed
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
}
