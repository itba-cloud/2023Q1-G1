terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
  required_version = ">= 1.0.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}