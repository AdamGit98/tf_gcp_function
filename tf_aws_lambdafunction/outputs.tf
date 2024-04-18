output "logging_name" {
  value       = aws_cloudwatch_log_group.lambda.name
  description = "Cloudwatch logging group for this lambda"
}

output "version" {
  value       = aws_lambda_function.lambda.version
  description = "AWS Version for this lambda"
}

output "invoke_arn" {
  value       = aws_lambda_function.lambda.invoke_arn
  description = "ARN required for invoking this lambda"
}
output "arn_policies" {
  value       = aws_iam_role_policy_attachment.policies.*
  description = "ARM for the AWS policies for this lambda"
}