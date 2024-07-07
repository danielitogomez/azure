variable "location" {
  type        = string
  description = "Enter the location where you want to deploy the resources"
  default     = "westus"
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group name in your Azure subscription."
}

variable "subscription_id" {
  type        = string
  default     = ""
  description = "SubscriptionID based on your Mgmt group."
}

variable "client_id" {
  type        = string
  default     = ""
  description = "AppID or ClientID in your Azure subscription."
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "SubscriptionID in your Azure subscription."
}

variable "tenant_id" {
  type        = string
  default     = ""
  description = "TenantID in your Azure subscription."
}

variable "prefix" {
  type        = string
  default     = "mi"
  description = "Prefix of the resource name"
}

variable "sku_name" {
  type        = string
  description = "Enter SKU"
  default     = "GP_Gen5_2"
}

variable "license_type" {
  type        = string
  description = "Enter license type"
  default     = "BasePrice"
}

variable "storage_size_in_gb" {
  type        = number
  description = "Enter storage size in GB"
  default     = 50
}
