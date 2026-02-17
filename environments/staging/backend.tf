terraform {
  backend "s3" {
    bucket         = "tfstate-car-lab"        #  S3 bucket you just created
    key            = "staging/terraform.tfstate"  #path/name of the state file inside the bucke
    region         = "us-east-1"              #same region as the bucket
    dynamodb_table = "tfstate-locks"          # create manually in DynamoDB
    encrypt        = true
  }
}