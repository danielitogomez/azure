# Azure App Service with Terraform using an existing Resource Group and App Service Plan

This repository contains Terraform scripts to deploy an Azure Linux Web App using an existing App Service Plan and Resource Group. The App Service Plan is manually created to adhere to subscription policies, and the Web App is then deployed using this existing App Service Plan.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v0.14.9 or later
- Azure Subscription
- Azure Service Principal with the necessary permissions
- Existing App Service Plan created in Azure Portal

## Project Structure

- `main.tf`: The main Terraform configuration file.
- `variables.tf`: This file contains the variables used in the Terraform scripts.
- `provider.tf`: Configuration for the Azure provider.

## Configuration

### Variables

The `variables.tf` file contains the variables used for the deployment. Default values are provided, but you can customize them as needed.

- `resource_group_location`: Location of the resource group.
- `resource_group_name`: Resource group name in your Azure subscription.
- `subscription_id`: Azure subscription ID.
- `client_id`: Azure client ID (Service Principal).
- `client_secret`: Azure client secret (Service Principal).
- `tenant_id`: Azure tenant ID.
- `random_integer_min`: Minimum value for random integer.
- `random_integer_max`: Maximum value for random integer.
- `os_type`: OS type for the App Service Plan.
- `https_only`: Enable HTTPS only.
- `minimum_tls_version`: Minimum TLS version.
- `repo_url`: URL of the GitHub repository.
- `branch`: Branch of the GitHub repository.
- `use_manual_integration`: Use manual integration for source control.
- `use_mercurial`: Use Mercurial for source control.

### Provider Configuration

The `provider.tf` file contains the configuration for the Azure provider. Ensure you have the necessary credentials and permissions set up.

## Usage

### Step 1: Create the App Service Plan Manually

1. Log in to the Azure Portal.
2. Navigate to the App Service Plans section.
3. Fill in the required details for the App Service Plan.
4. Click on the "Review + create" button.
5. Click on the "Create" button.
6. Wait for the App Service Plan to be created and replace the variable name_existing_service_plan

### Step 2: Update Terraform Variables

Update the `variables.tf` file with the appropriate values.

### Step 3: Initialize Terraform

Run the following command to initialize Terraform:
```sh
terraform init
```

### Step 3: Plan the Deployment

Run the following command to plan the deployment:
```sh
terraform plan
```

### Step 4: Apply the Configuration
Run the following command to apply the configuration:
```sh
terraform apply --auto-approve
```

### Step 5: Cleanup

1. Delete the App Service Plan
2. Destroy the infra
```sh
terraform destroy --auto-approve
```
