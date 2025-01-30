resource "azurerm_resource_group" "devRGWeb" {
  name     = "${var.env_prefix}-RG-Web"
  location = var.RGWeb_location

  tags = {
    Name = "${var.env_prefix}-RG-Web"
  }
}