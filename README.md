TERRAFORM AWS LAB – MODULAR, MULTI-ENVIRONMENT INFRASTRCUTURE

This project automates the deployment of a complete AWS infrastructure using Terraform, modular IaC design, and GitHub Actions. It provisions VPC networking, public/private subnets, security groups, Linux EC2 instances, and monitoring components — all deployed through a secure, environment‑aware CI/CD pipeline.

PROJECT OVERVIEW

This repository follows a multi‑environment Terraform architecture, separating staging and production deployments while sharing reusable modules.
The design emphasizes:

• 	Infrastructure modularity

• 	Environment isolation

• 	Remote state management (S3 + DynamoDB)

• 	CI/CD automation via GitHub Actions

• 	Reproducible deployments

• 	Clean, scalable Terraform structure

TERRAFORM MODULES

The infrastructure is broken into three core modules:

1. Networking Module (modules/networking)
Creates all network‑related resources:

- VPC
- Public subnet
- Private subnet
- Internet Gateway
- Route tables + associations
- Security Groups for frontend and backend
- Ingress/egress rules
This module defines the entire network topology for both environments.

2. Compute Module (modules/compute)
   
   Deploys compute resources:
   
- Frontend EC2 instance
  
- Backend EC2 instance
  
- Elastic IP for frontend
  
- Network Interfaces
  
- Security group attachments
  
- Key pair reference (key_name)
  
Instances are fully parameterized and environment‑aware.

3. Monitoring Module (modules/monitoring)
   
Provides observability components:

- CloudWatch Log Groups
  
- Instance‑level monitoring configuration
  
- Extension point for alarms and dashboards
  
This module keeps monitoring decoupled and reusable.

ENVIRONMENT STRUCTURE

Each environment has its own folder under environments/:

Staging
environments/staging/

  backend.tf
  
  main.tf
  
  variables.tf
  
  staging.tfvars

Productiion
environments/production/

  backend.tf
  
  main.tf
  
  variables.tf
  
  production.tfvars

  Each environment includes:
  
• 	Its own remote backend (S3 bucket + DynamoDB lock table)

• 	Its own variable definitions

• 	Its own tfvars file

• 	Its own state file stored remotely

• 	Complete isolation between staging and production

This ensures safe testing, promotion, and rollback workflows.

REMOTE BACKEND (AWS S3 + DynamoDB)

Both environments use:

• 	S3 bucket for Terraform state

• 	DynamoDB table for state locking

This enables:

• 	Team‑safe deployments

• 	CI/CD‑safe deployments

• 	No local state files

• 	Automatic locking during apply

GITHUB ACTIONS WORKFLOW

All workflows are located in

.github/workflows/deploy.yml

Workflow: deploy.yml

Purpose:

Primary Terraform deployment pipeline for both staging and production.

Features:

  - Manual environment selection (workflow_dispatch)
    
  - AWS authentication using GitHub Secrets
    
  - Terraform init → validate → plan → apply
    
  - Environment‑specific backend + variable loading
    
  - Plan summary output
    
  - Safe, idempotent applies
    
  - Clean working directory handling

SECRETS REQUIRED

--> Set the following secrets in your GitHub repository:

AWS_ACCESS_KEY_ID

--> IAM access key for Terraform automation.

AWS_SECRET_ACCESS_KEY

-->IAM secret key for Terraform automation.

AWS_REGION

--> Region for deployments (e.g., us-east-1).

These credentials allow GitHub Actions to authenticate to AWS and run Terraform commands.

FILE STRUCTURE

.github/workflows/

  deploy.yml

environments/

  staging/
  
    backend.tf
    
    main.tf
    
    variables.tf
    
    staging.tfvars

  production/
    backend.tf
    
    main.tf
    
    variables.tf
    
    production.tfvars

modules/

  networking/
  
    main.tf
    
    variables.tf
    
    outputs.tf

  compute/
  
    main.tf
    
    variables.tf
    
    outputs.tf

  monitoring/
  
    main.tf
    
    variables.tf
    
    outputs.tf

.gitignore

README.md








