locals {
  NameExp = "${var.env_prefix}-Hub"
}

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
  resource_group_name       = azurerm_resource_group.devSPOne.name
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
  resource_group_name       = azurerm_resource_group.devSPTwo.name
  virtual_network_name      = azurerm_virtual_network.spokeTwoVnet.name
  remote_virtual_network_id = azurerm_virtual_network.vnetHub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic = true
  depends_on = [azurerm_subnet.subnets,azurerm_subnet.spokeTwosubnets]
}

# security Group for EC2 instance - as this for testing purpose opening ports for everyone

resource "azurerm_network_security_group" "HubNSGVMS" {
  name                = "${local.NameExp}-NSG-For-VMs"
  location            = azurerm_virtual_network.vnetHub.location
  resource_group_name = azurerm_resource_group.devRGHub.name
}

resource "azurerm_network_security_rule" "HubNSGRULEVMSTCP" {
  name                        = "${local.NameExp}-NSG-TCPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allowing All Traffic For Now"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devRGHub.name
  network_security_group_name = azurerm_network_security_group.HubNSGVMS.name
}

resource "azurerm_network_security_rule" "HubNSGRULEVMSICMP" {
  name                        = "${local.NameExp}-NSG-ICMPRule-For-VMs"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allowing All Traffic For Now"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devRGHub.name
  network_security_group_name = azurerm_network_security_group.HubNSGVMS.name
}