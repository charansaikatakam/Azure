resource "azurerm_virtual_network" "vnetHub" {
  name                = "${var.env_prefix}-vnet-Hub"
  location            = var.vnetWeb_location
  resource_group_name = azurerm_resource_group.devRGHub.name
  address_space       = var.vnet_address_space
  depends_on = [azurerm_resource_group.devRGHub]
}

resource "azurerm_subnet" "subnets" {
  for_each = var.SubnetNamesAndAddressSpaces
  name                 = each.key
  resource_group_name  = azurerm_resource_group.devRGHub.name
  virtual_network_name = azurerm_virtual_network.vnetHub.name
  address_prefixes     = each.value
}

#vnet Peering with Spoke One

resource "azurerm_virtual_network_peering" "hubToSpokeOne" {
  name                      = "${var.env_prefix}-peering-Hub-to-spokeOne"
  resource_group_name       = azurerm_resource_group.devRGHub.name
  virtual_network_name      = azurerm_virtual_network.vnetHub.name
  remote_virtual_network_id = azurerm_virtual_network.spokeOneVnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  depends_on = [azurerm_subnet.subnets,azurerm_subnet.spokeOnesubnets]
}

resource "azurerm_virtual_network_peering" "SpokeOneToHub" {
  name                      = "${var.env_prefix}-peering-spokeOne-to-Hub"
  resource_group_name       = azurerm_resource_group.devRGHub.name
  virtual_network_name      = azurerm_virtual_network.spokeOneVnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnetHub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  depends_on = [azurerm_subnet.subnets,azurerm_subnet.spokeOnesubnets]
}

#vnet Peering with Spoke Two

resource "azurerm_virtual_network_peering" "hubToSpokeTwo" {
  name                      = "${var.env_prefix}-peering-Hub-to-spokeTwo"
  resource_group_name       = azurerm_resource_group.devRGHub.name
  virtual_network_name      = azurerm_virtual_network.vnetHub.name
  remote_virtual_network_id = azurerm_virtual_network.spokeTwoVnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  depends_on = [azurerm_subnet.subnets,azurerm_subnet.spokeTwosubnets]
}

resource "azurerm_virtual_network_peering" "SpokeTwoToHub" {
  name                      = "${var.env_prefix}-peering-spokeTwo-to-Hub"
  resource_group_name       = azurerm_resource_group.devRGHub.name
  virtual_network_name      = azurerm_virtual_network.spokeTwoVnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnetHub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  depends_on = [azurerm_subnet.subnets,azurerm_subnet.spokeTwosubnets]
}