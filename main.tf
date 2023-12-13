provider "aws" {
  region = var.your_region
}

resource "random_uuid" "my-long-unique-name" {}


module "website_s3_bucket" {
  source         = "./modules/aws-s3-web-bucket"
  s3_bucket-name = "${var.unique-bucket-name.name}-${var.unique-bucket-name.env}-${random_uuid.my-long-unique-name.result}"

}


