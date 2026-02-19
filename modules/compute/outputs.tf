###############################################
# COMPUTE MODULE — OUTPUTS
# These outputs expose EC2 instance details
# to the environment or other modules.
###############################################

output "frontend_instance_id" {
  value       = aws_instance.frontend.id
  description = "Frontend EC2 instance ID"
}

output "backend_instance_id" {
  value       = aws_instance.backend.id
  description = "Backend EC2 instance ID"
}

output "frontend_public_ip" {
  value       = aws_instance.frontend.public_ip
  description = "Frontend public IP"
}

output "backend_private_ip" {
  value       = aws_instance.backend.private_ip
  description = "Backend private IP"
}