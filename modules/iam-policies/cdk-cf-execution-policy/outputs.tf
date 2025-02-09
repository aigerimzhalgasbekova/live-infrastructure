output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.cdk_custom_cf_execution_policy.arn
}
