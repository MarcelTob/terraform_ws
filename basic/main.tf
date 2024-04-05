# Local variables
locals {
  location = "west europe"
}


resource "azurerm_resource_group" "ws" {
  name     = "ws-dev-mato-rg"
  location = local.location
}

# Deploy resource for specific workspace only
resource "azurerm_resource_group" "ws_workspace" {
  count    = terraform.workspace == "dev" ? 1 : 0
  name     = "ws-workspace-dev-mato-rg"
  location = local.location
}

# Import resource into state
# import {
#   to = azurerm_resource_group.ws
#   id = "/subscriptions/00000-0000-000000-000000-0000000/resourceGroups/ws-dev-mato-rg"
# }

# data resource to use objects not managed by terraform
data "azurerm_virtual_network" "ws" {
  name                = "vnet-dev-mato-vm"
  resource_group_name = "vm-dev-mato-rg"
}

output "vnet" {
  value = data.azurerm_virtual_network.ws.address_space
}

output "message" {
  value = var.message
}
