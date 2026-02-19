terraform {
  backend "s3" {
    bucket         = "tfstate-car-lab"        # S3 bucket you just created
    key            = "production/terraform.tfstate" # Path to state file inside the bucket
    region         = "us-east-1"              # Region where the bucket exists
    dynamodb_table = "tfstate-locks"          # DynamoDB table for state locking
    encrypt        = true                     # Encrypt state at rest
  }
}