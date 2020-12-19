#############################
#Provider
#############################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.27.0"
    }
  }

}

provider "azurerm" {
  version         = "2.27.0"
  features {}
}

