output "vpc_id" {
  description = "ID of the main vpc"
  value       = module.vpc.vpc_id
}

output "vpc_private_route_table_ids" {
  description = "IDs of the private route tables"
  value       = module.vpc.private_route_table_ids
}

output "vpc_private_subnets" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}