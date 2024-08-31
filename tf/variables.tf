variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "lti-project"
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "test-13"
}

variable "datadog_api_key" {
  description = "The Datadog API key"
  type        = string
}

variable "datadog_app_key" {
  description = "The Datadog app key"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "datadog_external_id" {
  description = "The Datadog external ID"
  type        = string
}