region             = "us-east-1"
vpc_cidr_block     = "10.1.0.0/16"
public_subnet_cidr = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"

instance_type = "t3.small"
key_name      = "car-aws-key"

frontend_name = "frontend-ec2-production"
backend_name  = "backend-ec2-production"

log_group_name      = "/aws/lab/production"
log_retention_days  = 30

tags = {
  Environment = "production"
  Project     = "TerraAWS1"
}