resource "azurerm_virtual_network" "spokeOneVnet" {
  name                = "${var.env_prefix}-vnet-spokeOne"
  location            = var.vnetSpokeOne_location
  resource_group_name = azurerm_resource_group.devSPOne.name
  address_space       = var.vnetSpokeOne_address_space
}

resource "azurerm_subnet" "spokeOnesubnets" {
  for_each = var.SpokeOneSubnetNamesAndAddressSpaces
  name                 = "${var.env_prefix}-${each.key}"
  resource_group_name  = azurerm_resource_group.devSPOne.name
  virtual_network_name = azurerm_virtual_network.spokeOneVnet.name
  address_prefixes     = each.value
}