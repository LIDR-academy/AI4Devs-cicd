locals {
  project_name = var.project_name
  environment  = var.environment

  s3_bucket_name        = "${local.project_name}-${local.environment}-code-bucket"
  ec2_role_name         = "${local.project_name}-${local.environment}-ec2-role"
  instance_profile_name = "${local.project_name}-${local.environment}-ec2-instance-profile"
  s3_access_policy_name = "${local.project_name}-${local.environment}-s3-access-policy"
  datadog_role_name     = "datadog-role"
  datadog_integration_role = "${local.project_name}-${local.environment}-DatadogAWSIntegrationRole"
  datadog_policy_name   = "${local.project_name}-${local.environment}-DatadogAWSIntegrationPolicy"
  aws_security_group    = "${local.project_name}-${local.environment}-sg"
  tag_name              = local.project_name
}