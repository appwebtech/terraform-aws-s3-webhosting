terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24.0"
    }
  }
  required_version = "~> 1.2"

  cloud {
    organization = "josembi-manchester-2023"
    workspaces {
      name = "aws-s3-web-hosting"
    }
  }
}