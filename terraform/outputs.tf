output "bucket_name" {
  value       = aws_s3_bucket.test.bucket
  description = "The name of the S3 bucket"
}
