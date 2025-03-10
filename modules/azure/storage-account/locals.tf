locals {
  name = "sa${var.prefix}${replace(var.name, "-", "")}${var.environment}"
  tags = merge(var.tags, { environment = var.environment })
}
