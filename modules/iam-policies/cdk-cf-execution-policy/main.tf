resource "aws_iam_policy" "cdk_custom_cf_execution_policy" {
  name        = var.policy_name
  description = "Custom policy for CDK CloudFormation execution"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "apigateway:*",
          "cloudwatch:*",
          "cognito-identity:*",
          "dynamodb:*",
          "ec2:*",
          "lambda:*",
          "logs:*",
          "s3:*",
          "ssm:*",
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "eu-west-1"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "cloudfront:*"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
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
          "kms:TagResource",
          "kms:UntagResource"
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "eu-west-1"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "iam:*Role*",
          "iam:GetPolicy",
          "iam:CreatePolicy",
          "iam:DeletePolicy",
          "iam:*PolicyVersion*"
        ],
        NotResource = [
          "arn:aws:iam::*:role/cdk-*",
          "arn:aws:iam::*:policy/${var.policy_name}"
        ]
      }
    ]
  })
}
