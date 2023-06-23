variable "dynamodb_vpc_endpoint_cidr_blocks" {
  description = "cidr blocks of the dynamodb table name"
  type = list(string)
}

variable "dynamodb_arn" {
  description = "arn of the dynamodb table name"
  type = string
}

variable "vpc_id" {
  description = "vpc id of the dynamodb table name"
  type = string
}

variable "vpc_private_subnets" {
  description = "vpc private subnets"
  type = list(string)
}