# Hub Spoke Architecture

This creates a vnet and following standard subnets in Hub.

1. JumpServersSubnet
2. AzureFirewallSubnet
3. AzureBastionSubnet
4. GatewaySubnet
5. PvtEndpointSubnet

Along with above it creates two spoke with one subnet each.

Hub to spokes are peered.