# General Variables

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Name of the web application"
  type        = string
  default     = "web-app"
}

variable "environment_name" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}


variable "nextjs_export_directory" {
  description = "Static export directory of NextJS App"
  type = string
}


variable "domain_name" {
  description = "Domain name"
  type        = string
}


variable "create_dns_zone" {
  description = "If true, create new route53 zone, if false read existing route53 zone"
  type        = bool
  default     = false
}


variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "db_user" {
  description = "Username for DB"
  type        = string
}

variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true
}



