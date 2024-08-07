provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "test" {
  bucket = var.bucket_name

  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "test-bucket"
    Environment = "dev"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.test.bucket
}
