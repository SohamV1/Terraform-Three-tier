terraform {
  backend "s3" {
    bucket         = "three-tier-backend-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "three-tier-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}