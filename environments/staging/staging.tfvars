region             = "us-east-1"
vpc_cidr_block     = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

instance_type = "t3.micro"
key_name      = "car-aws-key"

frontend_name = "frontend-ec2-staging"
backend_name  = "backend-ec2-staging"

log_group_name      = "/aws/lab/staging"
log_retention_days  = 30

tags = {
  Environment = "staging"
  Project     = "TerraAWS1"
}