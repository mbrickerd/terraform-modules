terraform {
  required_version = ">= 1.4.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.41, < 7"
    }
  }
}
