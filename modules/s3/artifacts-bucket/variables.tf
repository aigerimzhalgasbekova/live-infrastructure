variable "create_bucket" {
  type        = bool
  default     = true
  description = "Whether to create the S3 bucket."
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID for bucket encryption."
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Whether to block public ACLs."
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Whether to block public policy."
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Whether to ignore public ACLs."
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether to restrict public buckets."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to the S3 bucket."
}

variable "noncurrent_version_expiration_days" {
  type        = number
  default     = 14
  description = "The number of days to keep noncurrent versions."
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources are created"
}
