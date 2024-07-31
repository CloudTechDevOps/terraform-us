terraform {
  backend "s3" {
    bucket = "kdbisdvhisvxhisv"
    key    = "day-3/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, note: first run day-4-statefile-s3
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
  }
}
