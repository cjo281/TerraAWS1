variable "log_group_name" {
  type        = string
  description = "CloudWatch Log Group name"
}

variable "retention_days" {
  type        = number
  description = "Log retention in days"
}

variable "tags" {
  type = map(string)
}