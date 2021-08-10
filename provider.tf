terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.20"
    }
  }
}

provider "aws" {
  # alias = "dev"
  # version = "~> 3.20"
  profile                 = var.profile
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}
