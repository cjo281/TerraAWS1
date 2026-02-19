
###############################################################
# STAGING ENVIRONMENT — MAIN CONFIGURATION
# This file wires together:
# - AWS provider
# - Networking module
# - Compute module
# - Monitoring module
###############################################################


# -------------------------
# AWS Provider
# -------------------------

provider "aws" {
  region = var.region                                   # Region passed from staging.tfvars
}

# -------------------------
# NETWORKING MODULE
# Creates:
# - VPC
# - Public + private subnets
# - Route table + IGW
# - Security groups
# -------------------------

module "networking" {
  source                = "../../modules/networking"
  vpc_cidr_block        = var.vpc_cidr_block
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  tags                  = var.tags                      # Common tags for all resources
}

# -------------------------
# COMPUTE MODULE
# Deploys:
# - Frontend EC2 (public subnet)
# - Backend EC2 (private subnet)
# -------------------------

module "compute" {
  source              = "../../modules/compute"
  vpc_id              = module.networking.vpc_id
  public_subnet_id    = module.networking.public_subnet_id
  private_subnet_id   = module.networking.private_subnet_id
  frontend_sg_id      = module.networking.frontend_sg_id
  backend_sg_id       = module.networking.backend_sg_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  frontend_name       = var.frontend_name
  backend_name        = var.backend_name
  tags                = var.tags
}

# -------------------------
# MONITORING MODULE
# Creates:
# - CloudWatch Log Group
# -------------------------

module "monitoring" {
  source          = "../../modules/monitoring"
  log_group_name  = var.log_group_name
  retention_days  = var.log_retention_days
  tags            = var.tags
}