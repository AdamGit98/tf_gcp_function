variable "aws_region" {
  description = "AWS region to be deployed into."
  type        = string
}

variable "lambda_name" {
  type        = string
  description = "lambda name"
}
variable "python_runtime" {
  type        = string
  default     = "python3.9"
  description = "Required python runtime"
}

variable "description" {
  type        = string
  default     = ""
  description = "lambda description"
}
variable "log_retention_period" {
  type        = number
  default     = 30
  description = "AWS log retention period for this lambda in days"
}

variable "lambda_log_level" {
  type        = string
  description = "Log level for the Lambda Python runtime."
  default     = "DEBUG"
}

variable "lambda_version" {
  type        = string
  default     = "0.0.0"
  description = "reqiured lambda version"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "default memory size for the lambda"
}

variable "timeout" {
  type        = number
  default     = 30
  description = "Default timout for the lambda in seconds"
}

variable "lambda_source" {
  type        = string
  description = "relative path for the lambda source code"
}

variable "iam_role_name" {
  type        = string
  description = "name for the IAM role"
}

variable "policy_arn" {
  type        = set(string)
  description = "polices for the ARN"
}

variable "layers" {
  type        = set(string)
  default     = []
  description = "ARN of any layers used for this lambda"
}