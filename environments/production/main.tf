provider "aws" {
  region = var.region
}

# Networking
module "networking" {
  source                = "../../modules/networking"
  vpc_cidr_block        = var.vpc_cidr_block
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  tags                  = var.tags
}

# Compute
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

# Monitoring
module "monitoring" {
  source          = "../../modules/monitoring"
  log_group_name  = var.log_group_name
  retention_days  = var.log_retention_days
  tags            = var.tags
}