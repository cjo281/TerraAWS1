###############################################
# NETWORKING MODULE — VARIABLES
# These variables allow the networking module
# to be reused across staging and production.
###############################################

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

variable "tags" {
  description = "Common tags"
  type        = map(string)
}