resource "azurerm_resource_group" "devRGHub" {
  name     = "${var.env_prefix}-RG-Hub"
  location = var.RGWeb_location

  tags = {
    Name = "${var.env_prefix}-RG-Hub"
  }
}

resource "azurerm_resource_group" "devSPOne" {
  name     = "${var.env_prefix}-RG-Spoke-one"
  location = var.RGWeb_location

  tags = {
    Name = "${var.env_prefix}-RG-Spoke-one"
  }
}

resource "azurerm_resource_group" "devSPTwo" {
  name     = "${var.env_prefix}-RG-Spoke-Two"
  location = var.RGWeb_location

  tags = {
    Name = "${var.env_prefix}-RG-Spoke-Two"
  }
}