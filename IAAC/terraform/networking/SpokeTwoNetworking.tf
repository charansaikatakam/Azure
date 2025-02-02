locals {
  NameExpSpokeTwo = "${var.env_prefix}-SpokeTwo"
}

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

# security Group for EC2 instance - as this for testing purpose opening ports for everyone

resource "azurerm_network_security_group" "SpokeTwoNSGVMS" {
  name                = "${local.NameExpSpokeTwo}-NSG-For-VMs"
  location            = azurerm_resource_group.spokeTwoVnet.location
  resource_group_name = azurerm_resource_group.devSPTwo.name
}

resource "azurerm_network_security_rule" "SpokeTwoNSGRULEVMSTCP" {
  name                        = "${local.NameExpSpokeTwo}-NSG-TCPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allowing All Traffic For Now"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devSPTwo.name
  network_security_group_name = azurerm_network_security_group.SpokeTwoNSGVMS.name
}

resource "azurerm_network_security_rule" "SpokeTwoNSGRULEVMSICMP" {
  name                        = "${local.NameExpSpokeTwo}-NSG-ICMPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allowing All Traffic For Now"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devSPTwo.name
  network_security_group_name = azurerm_network_security_group.SpokeTwoNSGVMS.name
}