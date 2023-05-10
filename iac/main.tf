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



module "web_app_1" {
  source = "./web-app-module"

  # Input Variables
  domain_name      = var.domain_name
  app_name         = var.app_name
  environment_name = var.environment_name
  nextjs_export_directory = var.nextjs_export_directory
}


