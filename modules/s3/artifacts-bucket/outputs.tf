output "bucket_id" {
  description = "The S3 bucket ID"
  value       = aws_s3_bucket.this[0].id
}

output "bucket_arn" {
  description = "The S3 bucket ARN"
  value       = aws_s3_bucket.this[0].arn
}
