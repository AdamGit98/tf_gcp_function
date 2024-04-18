terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}