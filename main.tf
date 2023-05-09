terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.54.0"
    }
  }
}

provider "azurerm" {
    features{}
  # Configuration options

    subscription_id = "a2253605-f39c-45cf-b0ef-1feed6abc904"
    client_secret = "Ngr8Q~3c~C7bDumillfYy8tzb9gps9Wi.8m3YbnT"
    client_id = "9268cc44-4104-4581-ba1d-24326f2d1ce8"
    tenant_id = "7ab52cd7-5e5f-4d08-84bd-437d990c5ef4"
}

terraform {
  backend "azurerm" {
    storage_account_name = "sadev1985"
    container_name       = "tfstateback"
    key                  = "prod.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "Vgyzr1CbWlv8fZ0x2hsDjKKUfuAfDLZkMrqslaDj7ynZqMVtcnLPkBeMVjdAbXoMlxGO6igEfu7j+AStmxTxXg=="
  }
}


resource "azurerm_resource_group" "bermtec31" {
  name = "devops-bermtec"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "bermtec31-aks" {
  name                = "aks-demo"
  kubernetes_version  = "1.25.6"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.devops-bermtec.name
  dns_prefix          = "aks-demo"
  node_resource_group = "my_aks_tf_-node_resources_demo"
  default_node_pool {
    name       = "btsystem"
    node_count = "2"
    vm_size    = "Standard_D2s_v3"
    }
  identity {
    type = "SystemAssigned"
    }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "kubenet" # azure (CNI)
    }

  depends_on = [ azurerm_resource_group.devops-bermtec ]
  }
  
resource "azurerm_virtual_network" "demonetwork" {
  name                = "demonetwork"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "devops-bermtec"
  depends_on = [ azurerm_resource_group.devops-bermtec ]
}

resource "azurerm_subnet" "demosubnet" {
  name                 = "demosubnet"
  resource_group_name  = "devops-bermtec"
  virtual_network_name = "demonetwork"
  address_prefixes     = [ "10.0.2.0/24" ]
  depends_on = [ azurerm_virtual_network.demonetwork ]
  }

resource "azurerm_recovery_services_vault" "myvault" {
  name                = "demovault"
  location            = "estus"
  resource_group_name = "devops-bermtec"
  sku                 = "Standard"
  depends_on = [ azurerm_resource_group.devops-bermtec ]
}

resource "azurerm_storage_account" "sadev1985" {
  name                     = "sadev1985"
  location                 = "devops-bermtec"
  resource_group_name      = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.devops-bermtec ]
  #depends_on = [ azurerm_storage_account.sadev1985 ]
 }

# resource "azurerm_storage_share" "file-share" {
#    name                 = file-share
#    storage_account_name = var.storage_account_name
#    quota                = 100
  
#   }

resource "azurerm_storage_container" "tfstateback" {
  #name                 = "my-container-name"
   name                 = "tfstateback"
  storage_account_name = "sadev1985"
  depends_on = [ azurerm_storage_account.sadev1985 ]
}
 
# resource "azurerm_storage_account_network_rules" "test" {
#     resource_group_name = var.rgname
#     storage_account_name = sadev1985

    # default_action = "Deny" 
    # virtual_network_subnet_ids = [azurerm_subnet.demosubnet.id]
    # bypass = ["none"]
#}