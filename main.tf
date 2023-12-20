provider "aws" {
  region = var.your_region
}

resource "random_uuid" "my-long-unique-name" {}

module "aws-web-bucket" {
  source         = "./modules/aws-s3-web-bucket"
  s3_bucket-name = "${var.unique-bucket-name.name}-${var.unique-bucket-name.env}-${random_uuid.my-long-unique-name.result}"

}

# S3 Bucket object source and Encryption
resource "aws_s3_object" "web_bucket-objects" {
  key                    = "your-source-code.zip"
  bucket                 = module.aws-web-bucket.name
  source                 = "" # Path to your files
  server_side_encryption = "AES256"
}
