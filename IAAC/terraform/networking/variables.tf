variable env_prefix {
  type        = string
  default     = "dev"
  description = "Please provide the environment prefix"
}

variable vnet_address_space {
  type        = list
  default     = ["10.47.0.0/16"]
  description = "Please provide the vnet address space"
}

variable vnetWeb_location {
  type        = string
  default     = "Australia East"
  description = "Please provide the vnet location"
}

variable RGWeb_location {
  type        = string
  default     = "East US"
  description = "Please provide the web RG location"
}
#As I have the requiement of creating the all subnets with approximately with same configuration, creating with map
variable SubnetNamesAndAddressSpaces {
  type        = map(string)
  default     = {
    "JumpServersSubnet" = ["10.47.0.0/24"],
    "AzureFirewallSubnet" = ["10.47.10.0/24"],
    "AzureBastionSubnet" = ["10.47.20.0/24"],
    "GatewaySubnet" = ["10.47.30.0/24"],
    "PvtEndpointSubnet" = ["10.47.40.0/24"]
  }
  description = "Please provide the map of similar subnets address spaces and cidr ranges"
}
