output "id" {
  description = "The subnet ID."
  value       = azurerm_subnet.this.id
}

output "name" {
  description = "The name of the subnet."
  value       = azurerm_subnet.this.name
}

output "address_prefixes" {
  description = "The address prefixes for the subnet."
  value       = azurerm_subnet.this.address_prefixes
}
