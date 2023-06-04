terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
}


provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "k8sResourceGroup"
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "k8scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "k8scluster"

  default_node_pool {
    name       = "default"
    node_count = "1"
    vm_size    = "standard_d2_v2"
    enable_node_public_ip = true
  }

  identity {
    type = "SystemAssigned"
  }

}


