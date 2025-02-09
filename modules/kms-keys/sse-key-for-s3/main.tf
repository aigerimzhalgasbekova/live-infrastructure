resource "aws_kms_key" "s3_bucket_encryption_key" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  is_enabled              = true
  policy                  = data.aws_iam_policy_document.key_policy.json

  tags = var.tags
}

data "aws_iam_policy_document" "key_policy" {
  statement {
    sid    = "Allow account-wide management"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"] #Reference to the account ID
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:GenerateDataKey",
      "kms:TagResource",
      "kms:UntagResource"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "Allow S3 to use this key"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["s3.${var.aws_region}.amazonaws.com"]
    }
  }
}

resource "aws_kms_alias" "s3_bucket_encryption_key_alias" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.s3_bucket_encryption_key.key_id

  depends_on = [aws_kms_key.s3_bucket_encryption_key]
}

data "aws_caller_identity" "current" {}
