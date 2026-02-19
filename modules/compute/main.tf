###############################################
# COMPUTE MODULE — MAIN RESOURCES
# This module deploys:
# - Frontend EC2 instance (public subnet)
# - Backend EC2 instance (private subnet)
# - Uses Ubuntu 20.04 AMI (latest)
###############################################

# ----------------------------------------------------
# Lookup the most recent Ubuntu 20.04 LTS AMI
# ----------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true                      # Always pick the newest image

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]                      # Required for EC2 virtualization
  }

  owners = ["099720109477"]               # Canonical
}

# ----------------------------------------------------
# FRONTEND EC2 INSTANCE (Public Subnet)
# ----------------------------------------------------

resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.ubuntu.id       # Use the Ubuntu AMI above
  instance_type          = var.instance_type            # Instance size (t2.micro, etc.)
  subnet_id              = var.public_subnet_id         # Public subnet = public IP assigned
  vpc_security_group_ids = [var.frontend_sg_id]         # Attach frontend SG
  key_name               = var.key_name                 # SSH key pair

  tags = merge(var.tags, {
    Name = var.frontend_name                            # Custom name for frontend EC2
  })
}

# ----------------------------------------------------
# BACKEND EC2 INSTANCE (Private Subnet)
# ----------------------------------------------------

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id        # Private subnet = no public IP
  vpc_security_group_ids = [var.backend_sg_id]          # Attach backend SG
  key_name               = var.key_name

  tags = merge(var.tags, {
    Name = var.backend_name                             # Custom name for backend EC2
  })
}