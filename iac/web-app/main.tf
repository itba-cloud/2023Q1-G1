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

# variable "db_pass_1" {
#   description = "password for database #1"
#   type        = string
#   sensitive   = true
# }

# variable "db_pass_2" {
#   description = "password for database #2"
#   type        = string
#   sensitive   = true
# }

module "web_app_1" {
  source = "../web-app-module"

  # Input Variables
  domain_name      = var.domain_name
  app_name         = var.app_name
  environment_name = var.environment_name
  nextjs_export_directory = var.nextjs_export_directory
}

# module "web_app_2" {
#   source = "../web-app-module"

#   # Input Variables
#   domain_name      = "anotherdevopsdeployed.com"
#   app_name         = "web-app-2"
#   environment_name = "production"
#   instance_type    = "t2.micro"
#   create_dns_zone  = true
#   db_name          = "webapp2db"
#   db_user          = "bar"
#   db_pass          = var.db_pass_2
# }
