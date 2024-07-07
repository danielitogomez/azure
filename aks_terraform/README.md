# AKS creation using Terraform and deploy of nginx

This guide provides instructions to create an AKS Cluster and deploy an nginx deployment and service as a PoC.

## Prerequisites

- `az` configured to interact with Azure Cloud.
- `terraform` installed and configured.
- `kubectl` configured to interact with your AKS cluster.

## Steps

### 1. Initialize and Apply Terraform Configuration

First, ensure you have your Terraform configuration files set up for creating the AKS cluster.

#### Initialize Terraform
```sh
terraform init
```

#### Plan the Terraform Deployment
```sh
terraform plan
```

#### Apply the Terraform Deployment
```sh
terraform apply --auto-approve
```

### 2. Configure Kubernetes Credentials
Run the 00setup.sh script inside infra directory to set up your Kubernetes credentials. Make sure the script is executable:
```sh
chmod +x 00setup.sh
./00setup.sh
```

### 3. Deploy the Nginx Deployment and Service
Run the 00run.sh script inside k8s directory to deploy the deployment and service of nginx. Make sure the script is executable:
```sh
chmod +x 00run.sh
./00run.sh
```

#### Verify the Deployment and Service
You should see the nginx-deployment with the desired number of replicas running.
You should see the nginx-service with an external IP address assigned. It may take a few minutes for the external IP to be provisioned.
```sh
kubectl get deployments && kubectl get services
```

### 4. Access Nginx
Once the external IP is assigned, you can access the Nginx server using the external IP address. For example:
```sh
curl http://<external-ip>
```
You should see the default Nginx welcome page.

### 5. Clean Up
To remove the Nginx deployment and service, run:
```sh
kubectl delete -f nginx-deployment.yaml
kubectl delete -f nginx-service.yaml
```

To remove the Kubernetes cluster, run:
```sh
terraform destroy --auto-approve
```