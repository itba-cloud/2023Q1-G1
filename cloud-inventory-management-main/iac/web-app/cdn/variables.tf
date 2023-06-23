variable "static_site" {
  description = "Domain name for S3"
  type        = string
}
variable "web_origin_id" {
  description = "Id of the web origin."
  type        = string
}

variable "logs_bucket_domain_name" {
  description = "The domain name of the S3 bucket for the logs."
  type        = string
}