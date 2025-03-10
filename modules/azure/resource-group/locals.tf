locals {
  resource_group_name = "rg-${var.prefix}-${var.name}-${var.environment}"
  tags                = merge(var.tags, { environment = var.environment })
}
