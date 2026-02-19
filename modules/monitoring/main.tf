###############################################
# MONITORING MODULE — MAIN RESOURCES
# Creates a CloudWatch Log Group for EC2 logging,
# application logs, or future monitoring expansion.
###############################################

resource "aws_cloudwatch_log_group" "logs" {
  name              = var.log_group_name         # Log group name (passed from environment)
  retention_in_days = var.retention_days         # How long logs are kept

  tags = var.tags                                # Apply common tags
}