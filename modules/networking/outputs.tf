###############################################
# NETWORKING MODULE — OUTPUTS
# These outputs expose networking resources
# to other modules (compute, monitoring).
###############################################

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "Public subnet ID"
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
  description = "Private subnet ID"
}

output "frontend_sg_id" {
  value       = aws_security_group.frontend_sg.id
  description = "Frontend security group ID"
}

output "backend_sg_id" {
  value       = aws_security_group.backend_sg.id
  description = "Backend security group ID"
}