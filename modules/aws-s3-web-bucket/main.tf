# Create S3 bucket
resource "aws_s3_bucket" "web_bucket_name" {
  bucket = var.s3_bucket-name

  tags = var.resource-tags
}

# Configure S3 bucket
resource "aws_s3_bucket_website_configuration" "web_bucket_config" {
  bucket = aws_s3_bucket.web_bucket_name.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Bucket Ownership
resource "aws_s3_bucket_ownership_controls" "web_bucket" {
  bucket = aws_s3_bucket.web_bucket_name.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Enable public access to the bucket
resource "aws_s3_bucket_public_access_block" "web_bucket_public" {
  bucket = aws_s3_bucket.web_bucket_name.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "web_bucket_public" {
  bucket = aws_s3_bucket.web_bucket_name.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Configure Bucket CORS (Add your origin and configure the rules)
resource "aws_s3_bucket_cors_configuration" "web_bucket_public" {
  bucket = aws_s3_bucket.web_bucket_name.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}


# Create bucket policy
resource "aws_s3_bucket_policy" "web_bucket_policy" {
  bucket = aws_s3_bucket.web_bucket_name.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.web_bucket_name.arn,
          "${aws_s3_bucket.web_bucket_name.arn}/*",
        ]
      },
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.web_bucket_public]
}

