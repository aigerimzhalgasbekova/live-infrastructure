output "key_id" {
  description = "The KMS key ID"
  value       = aws_kms_key.s3_bucket_encryption_key.id
}

output "key_arn" {
  description = "The KMS key ARN"
  value       = aws_kms_key.s3_bucket_encryption_key.arn
}

output "alias_arn" {
  description = "The KMS alias ARN"
  value       = aws_kms_alias.s3_bucket_encryption_key_alias.arn
}
