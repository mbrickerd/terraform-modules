locals {
  name = "nsg-${var.prefix}-${var.name}-${var.environment}"
  tags = merge(var.tags, { environment = var.environment })
}
