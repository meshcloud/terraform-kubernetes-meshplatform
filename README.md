# Kubernetes meshPlatform Module

Terraform module to integrate Kubernetes as a meshPlatform into meshStack instance. The output of this module is a set of Service Account credentials that need to be configured in meshStack as described in [meshcloud public docs](https://docs.meshcloud.io/docs/meshstack.how-to.integrate-meshplatform.html).

## Prerequisites

To run this module, you need:

- cluster admin permissions on the cluster
- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [kubectl installed](https://kubernetes.io/docs/tasks/tools/#kubectl)

To integrate an AKS cluster, you additionally need:

- An AKS cluster with [Azure AD enabled](https://learn.microsoft.com/en-us/azure/aks/managed-aad)
- Integrate [RBAC based user access](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac) with the AKS cluster

## How to Use This Module

### Using CLI

1. Download the example `main.tf` and `outputs.tf` files.

    ```powershell
    # Downloads main.tf and outputs.tf files into ~/terraform-kubernetes-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-kubernetes-meshplatform/main/examples/basic-kubernetes-integration/main.tf -P ~/terraform-kubernetes-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-kubernetes-meshplatform/main/examples/basic-kubernetes-integration/outputs.tf -P ~/terraform-kubernetes-meshplatform
    ```

2. Open `~/terraform-kubernetes-meshplatform/main.tf` with a text editor. Modify the module variables and Terraform state backend settings in the file.

3. Execute the module.

    ```powershell
    # Changes into ~/terraform-kubernetes-meshplatform and applies terraform
    cd ~/terraform-kubernetes-meshplatform
    terraform init
    terraform apply
    ```

4. Configure the meshPlatform with the output provided by terraform.

    ```sh
    # The JSON output contains sensitive values that must not be transmitted to meshcloud in plain text.
    terraform output -json
    ```

## Example Usages

Check [examples](./examples/) for examples.
