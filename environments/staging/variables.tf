###############################################################
# STAGING ENVIRONMENT — VARIABLES
# These variables are populated by staging.tfvars
###############################################################

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "frontend_name" {
  description = "Frontend EC2 name"
  type        = string
}

variable "backend_name" {
  description = "Backend EC2 name"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch Log Group name"
  type        = string
}

variable "log_retention_days" {
  description = "Log retention in days"
  type        = number
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}