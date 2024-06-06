terraform {
  backend "s3" {
    bucket = "three-tier-backend-prod"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "three-tier-prod"
  }
}

provider "aws" {
  region = "us-east-1"
}