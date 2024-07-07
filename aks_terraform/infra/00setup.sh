#!/bin/bash

# Log in to Azure
az login --use-device-code

# Get the resource group name from Terraform output
resource_group_name=$(terraform output -raw resource_group_name)
echo "Resource Group Name: $resource_group_name"

# Get the Kubernetes cluster name
cluster_name=$(az aks list --resource-group $resource_group_name --query "[0].name" -o tsv)
echo "Kubernetes cluster name: $cluster_name"

# Get the credentials for the AKS cluster
az aks get-credentials --resource-group $resource_group_name --name $cluster_name --overwrite-existing

# Display the current contexts and nodes
kubectl config get-contexts && kubectl get nodes
