output "id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the Resource Group."
}

output "name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the Resource Group."
}
