variable "resource_group_location" {
  type        = string
  default     = "westus"
  description = "Location of the resource group."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "Size of the Nodes."
  default     = "Standard_D4s_v3"
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
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
