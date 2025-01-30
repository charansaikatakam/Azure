resource "azurerm_virtual_network" "vnetWeb" {
  name                = "${var.env_prefix}-vnet-web"
  location            = var.vnetWeb_location
  resource_group_name = azurerm_resource_group.devRGWeb.name
  address_space       = var.vnet_address_space
  depends_on = [azurerm_resource_group.devRGWeb]
}

resource "azurerm_subnet" "subnets" {
  for_each = var.SubnetNamesAndAddressSpaces
  name                 = each.key
  resource_group_name  = azurerm_resource_group.devRGWeb.name
  virtual_network_name = azurerm_virtual_network.vnetWeb.name
  address_prefixes     = each.value
}