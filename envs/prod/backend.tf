terraform {
  backend "s3" {
    bucket         = "tfstate-bucket"
    key            = "aws-infra/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}
