resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "app_bucket" {
  bucket        = "sandheep-app-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "app_bucket_public_access" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "app_bucket_name" {
  value       = aws_s3_bucket.app_bucket.id
  description = "The name of the application S3 bucket"
}
