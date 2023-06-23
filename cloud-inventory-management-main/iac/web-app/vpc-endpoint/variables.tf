variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "vpc_private_route_table_ids" {
  description = "vpc private route table ids"
  type        = list(string)
}

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}