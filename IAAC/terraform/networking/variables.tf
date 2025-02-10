variable env_prefix {
  type        = string
  default     = "dev"
  description = "Please provide the environment prefix"
}

variable vnet_address_space {
  type        = list
  default     = ["10.46.0.0/16"]
  description = "Please provide the vnet address space"
}

variable vnetWeb_location {
  type        = string
  default     = "Australia East"
  description = "Please provide the vnet location"
}

variable vnetSpokeOne_address_space {
  type        = list
  default     = ["10.47.0.0/16"]
  description = "Please provide the vnet address space"
}

variable vnetSpokeOne_location {
  type        = string
  default     = "Australia East"
  description = "Please provide the vnet location"
}

variable vnetSpokeTwo_address_space {
  type        = list
  default     = ["10.48.0.0/16"]
  description = "Please provide the vnet address space"
}

variable vnetSpokeTwo_location {
  type        = string
  default     = "Australia East"
  description = "Please provide the vnet location"
}

variable RGWeb_location {
  type        = string
  default     = "East US"
  description = "Please provide the web RG location"
}
#As I have the requiement of creating the all subnets with approximately with same configuration.
#and all subnet names are Azure spcific constant name, hence creating the subnets with the map.
variable SubnetNamesAndAddressSpaces {
  type        = map(list(string))
  default     = {
    "JumpServersSubnet" = ["10.46.0.0/24"],
    "AzureFirewallSubnet" = ["10.46.10.0/24"],
    "AzureBastionSubnet" = ["10.46.20.0/24"],
    "GatewaySubnet" = ["10.46.30.0/24"],
    "PvtEndpointSubnet" = ["10.46.40.0/24"]
  }
  description = "Please provide the map of similar subnets address spaces and cidr ranges"
}

variable SpokeOneSubnetNamesAndAddressSpaces {
  type        = map(list(string))
  default     = {
    "SpokeOneSubnet" = ["10.47.0.0/24"],
  }
  description = "Please provide the map of similar subnets address spaces and cidr ranges"
}


variable SpokeTwoSubnetNamesAndAddressSpaces {
  type        = map(list(string))
  default     = {
    "SpokeTwoSubnet" = ["10.48.0.0/24"],
  }
  description = "Please provide the map of similar subnets address spaces and cidr ranges"
}

variable isNatGWRequired {
  type = bool
  default = false
  description = "if false, it will not create any private subnet"
}