# Use existing resource group
data "azurerm_resource_group" "poc" {
  name = var.resource_group_name
}

# Create security group
resource "azurerm_network_security_group" "poc" {
  name                = "${random_pet.prefix.id}-nsg"
  location            = data.azurerm_resource_group.poc.location
  resource_group_name = data.azurerm_resource_group.poc.name
}

# Create a virtual network
resource "azurerm_virtual_network" "poc" {
  name                = "${random_pet.prefix.id}-vnet"
  resource_group_name = data.azurerm_resource_group.poc.name
  address_space       = ["10.0.0.0/24"]
  location            = data.azurerm_resource_group.poc.location
}

# Create a subnet
resource "azurerm_subnet" "poc" {
  name                 = "${random_pet.prefix.id}-subnet"
  resource_group_name  = data.azurerm_resource_group.poc.name
  virtual_network_name = azurerm_virtual_network.poc.name
  address_prefixes     = ["10.0.0.0/27"]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

# Associate subnet and the security group
resource "azurerm_subnet_network_security_group_association" "poc" {
  subnet_id                 = azurerm_subnet.poc.id
  network_security_group_id = azurerm_network_security_group.poc.id
}

# Create a route table
resource "azurerm_route_table" "poc" {
  name                          = "${random_pet.prefix.id}-rt"
  location                      = data.azurerm_resource_group.poc.location
  resource_group_name           = data.azurerm_resource_group.poc.name
  disable_bgp_route_propagation = false
}

# Associate subnet and the route table
resource "azurerm_subnet_route_table_association" "poc" {
  subnet_id      = azurerm_subnet.poc.id
  route_table_id = azurerm_route_table.poc.id

  depends_on = [azurerm_subnet_network_security_group_association.poc]
}

# Create MSSQL Server
resource "azurerm_mssql_server" "main" {
  name                         = "${random_pet.prefix.id}-mssqlserver"
  resource_group_name          = data.azurerm_resource_group.poc.name
  location                     = data.azurerm_resource_group.poc.location
  version                      = "12.0"
  administrator_login          = "${replace(random_pet.prefix.id, "-", "")}admin"
  administrator_login_password = random_password.password.result

  depends_on = [azurerm_subnet_route_table_association.poc]
}

# Create MSSQL Database (commented out)
resource "azurerm_mssql_database" "main" {
  name           = "${random_pet.prefix.id}-sqldb"
  server_id      = azurerm_mssql_server.main.id
  sku_name       = var.sku_name
  license_type   = var.license_type
  max_size_gb    = var.storage_size_in_gb
  zone_redundant = false
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "random_pet" "prefix" {
  prefix = var.prefix
  length = 1
}
