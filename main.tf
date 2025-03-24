terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.9.0"
    }
  }
}

provider "azurerm" {
  features {}

  resource_group_name  = "TF-blob"
  storage_account_name = "zulmuh"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"

}

resource "azurerm_resource_group" "tf-epift" {
  name     = "TF-rg"
  location = "Australia East"
}

resource "azurerm_container_group" "cg-epift" {
  name                = "zulmuh"
  location            = azurerm_resource_group.tf-epift.location
  resource_group_name = azurerm_resource_group.tf-epift.name

  ip_address_type = "Public"
  dns_name_label  = "dns-zulmuh"
  os_type         = "Linux"

  container {
    name   = "zulmuh"
    image  = "zulmuh/epift:v1"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}