terraform {
  required_version = ">= 0.13.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.0"
    }
  }
}

