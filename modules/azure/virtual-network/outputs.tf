output "id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "address_space" {
  description = "The list of address spaces used by the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

output "dns_servers" {
  description = "The list of DNS servers used by the virtual network."
  value       = azurerm_virtual_network.this.dns_servers
}

output "guid" {
  description = "The GUID of the virtual network."
  value       = azurerm_virtual_network.this.guid
}

output "subnets" {
  description = "The list of names of the subnets that are attached to this virtual network."
  value       = [for s in azurerm_virtual_network.this.subnet : s.name]
}
