

resource "azurerm_resource_group" "TerraFailLB_rg" {
  name     = "TerraFailLB_rg"
  location = "East US 2"
}

# ---------------------------------------------------------------------
# LoadBalancer
# ---------------------------------------------------------------------
resource "azurerm_lb" "TerraFailLB" {
  name                = "TerraFailLB"
  location            = azurerm_resource_group.TerraFailLB_rg.location
  resource_group_name = azurerm_resource_group.TerraFailLB_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.TerraFailLB_public_ip.id
  }
}

# ---------------------------------------------------------------------
# Network
# ---------------------------------------------------------------------
resource "azurerm_public_ip" "TerraFailLB_public_ip" {
  name                = "TerraFailLB_public_ip"
  resource_group_name = azurerm_resource_group.TerraFailLB_rg.name
  location            = azurerm_resource_group.TerraFailLB_rg.location
  allocation_method   = "Static"

  sku = "Standard"

  tags = {
    environment = "Production"
  }
}
