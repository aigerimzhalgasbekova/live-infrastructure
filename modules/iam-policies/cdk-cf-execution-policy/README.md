# CDK CloudFormation Execution Policy

This module creates a Custom CDK CloudFormation Execution Policy.

## Usage

To use this module, include it in your Terraform configuration as follows:

```tf
module "cdk_cf_execution_policy" {
  source      = "path/to/modules/iam-policies/cdk-cf-execution-policy"
  policy_name = "CdkCustomCFExecutionPolicy"
}
```

## Inputs

| Name        | Description                   | Type   | Default | Required |
|-------------|-------------------------------|--------|---------|----------|
| policy_name | The name of the IAM policy    | string | n/a     | yes      |

## Outputs

| Name       | Description                      |
|------------|----------------------------------|
| policy_arn | The ARN of the IAM policy        |

## Example

```hcl
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = ""path/to/modules/iam-policies/cdk-cf-execution-policy"
}

inputs = {
  policy_name = "CdkCustomCFExecutionPolicy"
}
```

After running `terraform apply`, you can use the outputted `policy_arn` in your CDK bootstrap command:

```sh
cdk bootstrap --cloudformation-execution-policies "<policy_arn>"
```