terraform {
  required_version = ">= 1.4.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.41, < 7"
    }
  }
}

# tflint-ignore: terraform_unused_declarations
variable "module_version" {
  type        = string
  default     = "0.0.1"
  description = "Current version of the GCP Terraform modules."
}
