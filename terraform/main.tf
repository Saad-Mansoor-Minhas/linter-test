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

  # Adding encryption configuration to use KMS
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  # Adding event notifications
  notification {
    # Example: Add a notification for S3 event types
    topic {
      events = ["s3:ObjectCreated:*"]
      topic_arn = aws_sns_topic.example.arn
    }
  }

  # Adding lifecycle configuration
  lifecycle_rule {
    id      = "example"
    enabled = true

    expiration {
      days = 365
    }
  }

  # Adding public access block configuration
  block_public_access {
    block_public_acls          = true
    ignore_public_acls         = true
    restrict_public_buckets    = true
    block_public_policy        = true
  }

  # Add access logging (if required, make sure to define the target bucket for logging)
  logging {
    target_bucket = aws_s3_bucket.logging_bucket.bucket
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "logging_bucket" {
  bucket = "${var.bucket_name}-logs"

  acl = "private"

  versioning {
    enabled = true
  }
}

output "bucket_name" {
  value = aws_s3_bucket.test.bucket
}
