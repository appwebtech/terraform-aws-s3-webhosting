# This terraform block houses a cloud block with arguments in which attributes must be configured in TF cloud. Please see the [link](https://developer.hashicorp.com/terraform/language/settings/terraform-cloud)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24.0"
    }
  }
  required_version = "~> 1.2"

  cloud {
    organization = "AWS-Cloud-Resume-2023"
    workspaces {
      name = "aws-s3-web-hosting"
    }
  }
}
