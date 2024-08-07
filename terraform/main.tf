# test-codebase/terraform/main.tf

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "test" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}
