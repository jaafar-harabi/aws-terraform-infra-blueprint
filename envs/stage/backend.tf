terraform {
  backend "s3" {
    bucket         = "tfstate-bucket"
    key            = "aws-infra/stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}
