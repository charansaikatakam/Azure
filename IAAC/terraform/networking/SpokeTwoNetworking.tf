resource "azurerm_virtual_network" "spokeTwoVnet" {
  name                = "${var.env_prefix}-vnet-spokeTwo"
  location            = var.vnetSpokeTwo_location
  resource_group_name = azurerm_resource_group.devSPTwo.name
  address_space       = var.vnetSpokeTwo_address_space
}

resource "azurerm_subnet" "spokeTwosubnets" {
  for_each = var.SpokeTwoSubnetNamesAndAddressSpaces
  name                 = "${var.env_prefix}-${each.key}"
  resource_group_name  = azurerm_resource_group.devSPTwo.name
  virtual_network_name = azurerm_virtual_network.spokeTwoVnet.name
  address_prefixes     = each.value
}