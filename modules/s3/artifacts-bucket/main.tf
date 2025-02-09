resource "aws_s3_bucket" "this" {
  count = var.create_bucket ? 1 : 0
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:key/${var.kms_key_id}"
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this[0].id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  depends_on = [aws_s3_bucket.this[0]] # Ensure bucket exists first
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this[0].id
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.this[0]] # Ensure bucket exists first
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this[0].id

  rule {
    id     = "CleanupOldVersions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
  }

  rule {
    id     = "AbortIncompleteMultipartUploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }

  depends_on = [aws_s3_bucket.this[0]] # Ensure bucket exists first
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.bucket_policy_document.json

  depends_on = [aws_s3_bucket.this[0]] # Ensure bucket exists first
}

data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this[0].arn,
      "${aws_s3_bucket.this[0].arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

data "aws_caller_identity" "current" {}
