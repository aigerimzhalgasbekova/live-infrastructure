include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/iam-policies/cdk-cf-execution-policy"
}

inputs = {
  policy_name = "CdkCustomCFExecutionPolicy"
}
