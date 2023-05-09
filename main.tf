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
