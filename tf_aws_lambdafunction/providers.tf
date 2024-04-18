terraform {
  required_providers {

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}