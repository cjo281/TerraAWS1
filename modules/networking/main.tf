###############################################
# NETWORKING MODULE — MAIN RESOURCES
# This module builds the complete AWS networking layer:
# - VPC
# - Public + Private subnets
# - Internet Gateway
# - Route table + association
# - Security groups for frontend + backend EC2 instances
###############################################


# -------------------------
# Create the main VPC
# -------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block    # Main network range for the VPC
  enable_dns_support   = true                  # Enables DNS resolution inside the VPC
  enable_dns_hostnames = true                  # Required for EC2 instances to receive DNS hostnames

  tags = merge(var.tags, {
    Name = "lab-vpc"                           # Identifies the VPC in AWS console                     
  })
}

# -------------------------
# Internet Gateway (for public subnet)
# -------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id                      # Attach IGW to the VPC

  tags = merge(var.tags, {
    Name = "lab-igw"
  })
}

# -------------------------
# Public Subnet
# -------------------------

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true                        # Ensures EC2 instances launched here receive public IPs


  tags = merge(var.tags, {
    Name = "public-subnet"
  })
}

# -------------------------
# Private Subnet
# -------------------------

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr

  tags = merge(var.tags, {
    Name = "private-subnet"
  })
}

# -------------------------
# Public Route Table
# -------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                    # Route all outbound traffic
    gateway_id = aws_internet_gateway.igw.id    # Send it through the IGW
  }

  tags = merge(var.tags, {
    Name = "public-rt"
  })
}

# Associate public subnet with public route table

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Security Group — Frontend EC2
# -------------------------

resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id

# Allow HTTP from anywhere
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]          # Public web access
  }

# Allow SSH from anywhere (you may restrict this later)
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]          # Wide-open SSH (not recommended for production)
  }

# Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "frontend-sg"
  })
}

# -------------------------
# Security Group — Backend EC2
# -------------------------
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow traffic from frontend"
  vpc_id      = aws_vpc.main.id

# Allow backend app traffic ONLY from frontend SG
  ingress {
    description      = "App traffic from frontend"
    from_port        = 1433                                 # SQL Server default port
    to_port          = 1433
    protocol         = "tcp"
    security_groups  = [aws_security_group.frontend_sg.id]  # Restrict to frontend SG only
  }

# Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "backend-sg"
  })
}