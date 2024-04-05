resource "azurerm_virtual_network" "ws" {
  count = length(var.vnets)

  name                = "vnet-${count.index}"
  location            = azurerm_resource_group.ws.location
  resource_group_name = azurerm_resource_group.ws.name

  address_space = element(var.vnets, count.index).address_space
}

resource "azurerm_virtual_network" "ws2" {
  # for each subnet 
  for_each = { for net in var.vnets : net.name => net }

  location            = azurerm_resource_group.ws.location
  resource_group_name = azurerm_resource_group.ws.name

  name          = each.key
  address_space = each.value.address_space

  # Dynamic block to create multiple nested blocks 
  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      address_prefix = subnet.value
      name           = subnet.key
    }
  }
}
