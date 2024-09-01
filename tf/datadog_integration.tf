resource "datadog_integration_aws" "aws_integration" {
  account_id   = var.aws_account_id
  role_name    = "datadog-integration-role"
  filter_tags  = ["env:production"]
  host_tags    = ["env:production"]
  account_specific_namespace_rules = {
    auto_scaling = false
  }
}

resource "aws_iam_role" "datadog_integration_role" {
  name = "datadog-integration-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "datadog.amazonaws.com"
        },
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_policy" "datadog_integration_policy" {
  name        = "datadog-integration-policy"
  description = "Policy for Datadog AWS integration"
  policy      = file("datadog_policy.json")
}

resource "aws_iam_role_policy_attachment" "datadog_integration_policy_attachment" {
  role       = aws_iam_role.datadog_integration_role.name
  policy_arn = aws_iam_policy.datadog_integration_policy.arn
}