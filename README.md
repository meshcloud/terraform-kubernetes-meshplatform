# Kubernetes meshPlatform Module

Terraform module to integrate Kubernetes as a meshPlatform into meshStack instance. With this module, service accounts used by meshStack are created with the required permissions.

## Prerequisites

To run this module, you need the following:

- Cluster admin permissions
- [Terraform installed](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [kubectl installed](https://kubernetes.io/docs/tasks/tools/#kubectl)

## How to Use This Module

### Using CLI

1. Download the example `main.tf` and `outputs.tf` files.

    ```powershell
    # Downloads main.tf and outputs.tf files into ~/terraform-kubernetes-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-kubernetes-meshplatform/main/examples/basic-aks-integration/main.tf -P ~/terraform-kubernetes-meshplatform
    wget https://raw.githubusercontent.com/meshcloud/terraform-kubernetes-meshplatform/main/examples/basic-aks-integration/outputs.tf -P ~/terraform-kubernetes-meshplatform
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

Check [examples](./examples/) for different use cases. As a quick start for AKS we recommend using [basic-aks-integration](./examples/basic-azure-integration) example.
