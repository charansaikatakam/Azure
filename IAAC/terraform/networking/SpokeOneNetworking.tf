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
  priority                    = 101
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

#Creating the NAT Gateway

resource "azurerm_nat_gateway" "NATGW" {
  name                    = "${local.NameExpSpokeOne}-nat-gateway"
  location                = azurerm_virtual_network.spokeOneVnet.location
  resource_group_name     = azurerm_resource_group.devSPOne.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_public_ip" "NATGWPIP" {
  name                = "${local.NameExpSpokeOne}-NAT-PIP"
  location            = azurerm_virtual_network.spokeOneVnet.location
  resource_group_name = azurerm_resource_group.devSPOne.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "NAGGWPIPAssosciation" {
  nat_gateway_id       = azurerm_nat_gateway.NATGW.id
  public_ip_address_id = azurerm_public_ip.NATGWPIP.id
}

resource "azurerm_subnet_nat_gateway_association" "NATGWSubnetAssosciation" {
  subnet_id      = azurerm_subnet.spokeOnesubnets.id
  nat_gateway_id = azurerm_nat_gateway.NATGW.id
}