resource "azurerm_resource_group" "RG" {
  name = "WNS-AUTODEPLOY-POC"
  location = "eastus"
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_virtual_network" "terraformvnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = [var.vnet_addr]
}

module "bastion" {
  source = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-bastion.git"
  bastion_rg_name = azurerm_resource_group.RG.name
  bastion_subnet_addr = ["10.0.0.2/24"]
  bastion_subnet_rg_name = azurerm_resource_group.RG.name
  bastion_subnet_vnet_name = azurerm_virtual_network.terraformvnet.name
  bastion_location = azurerm_resource_group.RG.location
  bastion_publicIp_Id = azurerm_public_ip.example.id
  bastion_tag = {
      env:"stage"
  }
}