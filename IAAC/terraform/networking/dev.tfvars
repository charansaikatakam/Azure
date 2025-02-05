env_prefix = "dev"
vnet_address_space = ["10.46.0.0/16"]
vnetWeb_location = "Australia East"
SubnetNamesAndAddressSpaces = {
    "JumpServersSubnet" = ["10.46.0.0/24"],
    "AzureFirewallSubnet" = ["10.46.10.0/24"],
    "AzureBastionSubnet" = ["10.46.20.0/24"],
    "GatewaySubnet" = ["10.46.30.0/24"],
    "PvtEndpointSubnet" = ["10.46.40.0/24"]
  }
vnetSpokeTwo_location = "Australia East"
vnetSpokeTwo_address_space = ["10.48.0.0/16"]
vnetSpokeOne_location = "Australia East"
vnetSpokeOne_address_space = ["10.47.0.0/16"]

SpokeOneSubnetNamesAndAddressSpaces = {
    "SpokeOneSubnet" = ["10.47.0.0/24"]
  }

SpokeTwoSubnetNamesAndAddressSpaces = {
    "SpokeTwoSubnet" = ["10.48.0.0/24"],
  } 

