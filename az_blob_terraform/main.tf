data "azurerm_client_config" "current" {}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name = random_string.storage_account_name.result

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
  }
}

#resource "azurerm_storage_container" "storage_container" {
#  name                  = "web-content"
#  storage_account_name  = azurerm_storage_account.storage_account.name
#  container_access_type = "blob"
#}
#
#resource "azurerm_storage_blob" "index_html" {
#  name                   = "index.html"
#  storage_account_name   = azurerm_storage_account.storage_account.name
#  storage_container_name = azurerm_storage_container.storage_container.name
#  type                   = "Block"
#  source                 = "${path.module}/index.html"
#}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}