# =============================================================================
# Local Values
# =============================================================================
# Centralized local values for use across the root module

locals {
  # Common tags to be applied to all resources
  tags = {
    freeformTags = {
      Environment = var.environment
      Application = var.app_name
      CreatedBy   = "Terraform"
    }
    definedTags = {}
  }

  # Note: timestamp() is intentionally removed as it causes plan changes on every run.
  # If unique naming is needed, consider using random_id resource or pass timestamp as variable.
}