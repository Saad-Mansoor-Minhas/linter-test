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
        kms_master_key_id = "your-kms-key-id"  # Replace with your KMS key ID
      }
    }
  }

  # Adding public access block configuration
  block_public_access {
    block_public_acls          = true
    ignore_public_acls          = true
    block_public_policy         = true
    restrict_public_buckets     = true
  }

  # Adding lifecycle configuration
  lifecycle_rule {
    id      = "example"
    enabled = true

    expiration {
      days = 365
    }
  }

  # Add access logging configuration
  logging {
    target_bucket = aws_s3_bucket.logging_bucket.bucket
    target_prefix = "logs/"
  }

  # Add cross-region replication configuration
  replication_configuration {
    role = aws_iam_role.replication_role.arn

    rule {
      id     = "example"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.replica_bucket.arn
        storage_class = "STANDARD"
      }

      filter {
        prefix = ""
      }
    }
  }
}

resource "aws_s3_bucket" "logging_bucket" {
  bucket = "${var.bucket_name}-logs"

  acl    = "private"

  versioning {
    enabled = true
  }

  # Add encryption configuration to use KMS
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = "your-kms-key-id"  # Replace with your KMS key ID
      }
    }
  }

  # Adding public access block configuration
  block_public_access {
    block_public_acls          = true
    ignore_public_acls          = true
    block_public_policy         = true
    restrict_public_buckets     = true
  }

  # Adding lifecycle configuration
  lifecycle_rule {
    id      = "example"
    enabled = true

    expiration {
      days = 365
    }
  }

  # Enable event notifications
  notification {
    topic {
      events = ["s3:ObjectCreated:*"]
      topic_arn = aws_sns_topic.example.arn
    }
  }
}

resource "aws_sns_topic" "example" {
  name = "example-topic"
}

resource "aws_iam_role" "replication_role" {
  name = "replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "s3.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_s3_bucket" "replica_bucket" {
  bucket = "${var.bucket_name}-replica"

  acl    = "private"

  versioning {
    enabled = true
  }

  # Adding encryption configuration to use KMS
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = "your-kms-key-id"  # Replace with your KMS key ID
      }
    }
  }

  # Adding public access block configuration
  block_public_access {
    block_public_acls          = true
    ignore_public_acls          = true
    block_public_policy         = true
    restrict_public_buckets     = true
  }
}
