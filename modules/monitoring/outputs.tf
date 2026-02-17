output "log_group_name" {
  value       = aws_cloudwatch_log_group.logs.name
  description = "CloudWatch Log Group name"
}

output "log_group_arn" {
  value       = aws_cloudwatch_log_group.logs.arn
  description = "CloudWatch Log Group ARN"
}