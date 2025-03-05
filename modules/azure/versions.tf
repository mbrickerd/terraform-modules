terraform {
  required_version = ">= 1.4.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0, < 4.0.0"
    }
  }
}

# tflint-ignore: terraform_unused_declarations
variable "module_version" {
  type        = string
  default     = "0.0.1"
  description = "Current version of the Azure Terraform modules."
}
