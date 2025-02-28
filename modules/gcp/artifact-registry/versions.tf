terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0, < 6.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.50.0, < 6.0.0"
    }
  }
}
