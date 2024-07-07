# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = var.random_integer_min
  max = var.random_integer_max
}

# Reference the existing App Service Plan
data "azurerm_service_plan" "existing" {
  name                = var.name_existing_service_plan
  resource_group_name = var.resource_group_name
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-${random_integer.ri.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id     = data.azurerm_service_plan.existing.id
  https_only          = var.https_only
  site_config {
    minimum_tls_version = var.minimum_tls_version
  }
}

# Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = var.repo_url
  branch                 = var.branch
  use_manual_integration = var.use_manual_integration
  use_mercurial          = var.use_mercurial
}
