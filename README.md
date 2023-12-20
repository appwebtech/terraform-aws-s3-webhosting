# Terraform Module for AWS S3

[![Terraform](https://img.shields.io/badge/Terraform-%23844FBA)](https://releases.hashicorp.com/terraform/)
[![License: Apache](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Repo-size](https://img.shields.io/github/repo-size/appwebtech/terraform-aws-s3-webhosting?labelColor=844FBA)](https://github.com/appwebtech/terraform-aws-s3-webhosting)
[![License: MPL 2.0](https://img.shields.io/badge/License-MPL_2.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)
[![Static Badge](https://img.shields.io/badge/github_actions-blue)](https://github.com/appwebtech/terraform-aws-s3-webhosting/actions)

## AWS S3 Bucket with Web Hosting Capabilities

This module will spin up the necessary infrastructure to host a website in AWS S3. The bucket is publicly accessible for API Get requests.
To keep costs at a minimum, I've employed a minimalist approach (*I didn't implement cross-region replication, CDN, Logging, encryption, lifecycle etc*) whilst  ensuring full functionality.

## Requirements

| Name | Version |
|------|---------|
| Terraform | ~> 1.2 |
| aws | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.0 |
| random_uuid | 3.6.0 |

## Modules

To be added after deployment to Terraform Cloud

## Usage

Please ensure you have Terraform installed in your environment. Visit the [Harshicorp website](https://developer.hashicorp.com/terraform/install) for both CLI and binary installations on various operating systems.

In macOS, I usually manage my package installations with [Homebrew](https://brew.sh/) which is ideal in this scenario.

To avoid backward incompatibility, you may need to upgrade your environment to `Terraform 1.2` and `aws 5.0` or higher.

AWS S3 buckets are unique globally. To avoid creation failure due to duplicates, I've incorporated [random_uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) resource. To supply a unique bucket name;

* Open `variables.tf` config file of the main root module.
* Add your bucket name under the `name` and `env` key values of the `unique-bucket-name` variable.

```tf
variable "unique-bucket-name" {
  type = map(string)
  default = {
    name = "your-bucket-name"
    env  = "prod"
  }
  description = "A unique bucket name with a randomized suffix"
}
```

If you are not utilizing Terraform Cloud, please feel free to comment out the nested cloud block in `terraform.tf` root configuration file. However, if you intend to persist your state files on the cloud, a Terraform Cloud setup is necessary.

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.2"

  cloud {
    organization = "YOUR-ORGANIZATION"
    workspaces {
      name = "YOU-WORKSPACE"
    }
  }
}
```

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_policy.website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.website_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_object.web_bucket-objects](https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/s3_object) | resource |
| [aws_s3_bucket_versioning.website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [random_uuid](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |