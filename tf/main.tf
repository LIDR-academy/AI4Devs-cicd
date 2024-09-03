resource "datadog_integration_aws" "sandbox" {
  account_id = var.aws_account_id
  role_name  = aws_iam_role.datadog_aws_integration.name
  filter_tags  = ["env:production"]
  host_tags    = ["env:production"]
  account_specific_namespace_rules = {
    auto_scaling = false
  }
}