locals {
  NameExpSpokeOne = "${var.env_prefix}-SpokeOne"
}

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

resource "azurerm_network_security_group" "SpokeOneNSGVMS" {
  name                = "${local.NameExpSpokeOne}-NSG-For-VMs"
  location            = azurerm_virtual_network.spokeOneVnet.location
  resource_group_name = azurerm_resource_group.devSPOne.name
}

resource "azurerm_network_security_rule" "SpokeOneNSGRULEVMSTCP" {
  name                        = "${local.NameExpSpokeOne}-NSG-TCPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devSPOne.name
  network_security_group_name = azurerm_network_security_group.SpokeOneNSGVMS.name
}

resource "azurerm_network_security_rule" "SpokeOneNSGRULEVMSICMP" {
  name                        = "${local.NameExpSpokeOne}-NSG-ICMPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devSPOne.name
  network_security_group_name = azurerm_network_security_group.SpokeOneNSGVMS.name
}