variable "aws_region" {
  description = "AWS region to be deployed into."
  type        = string
}

variable "lambda_name" {
  type = string
}

variable "python_runtime" {
  type    = string
  default = "python3.9"
}
variable "log_retention_period" {
  type    = number
  default = 30
}

variable "lambda_log_level" {
  description = "Log level for the Lambda Python runtime."
  default     = "DEBUG"
}

variable "description" {
  type    = string
  default = ""
}

variable "cloud_id" {
  type = string
}

variable "cohort" {
  type = number
}