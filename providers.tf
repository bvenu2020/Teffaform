terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.57.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

  features {}
    subscription_id = "a2253605-f39c-45cf-b0ef-1feed6abc904"
    client_secret = "Uzj8Q~CAVGEIxgafoZtDrXDG_yd1YoDUat2Jib3H"
    client_id = "9be6ab2a-2553-4499-bb77-899eb4b580e4"
    tenant_id = "7ab52cd7-5e5f-4d08-84bd-437d990c5ef4"
}
