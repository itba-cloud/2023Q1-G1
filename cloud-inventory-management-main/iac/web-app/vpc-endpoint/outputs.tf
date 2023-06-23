output "dynamodb_id" {
    description = "id of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.id 
}
output "dynamodb_arn" {
    description = "arn of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.arn 
}
output "dynamodb_dns_entry" {
    description = "dns entry of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.dns_entry 
}
output "dynamodb_owner_id" {
    description = "owner id of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.owner_id 
}
output "dynamodb_state" {
    description = "state of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.state 
}
output "dynamodb_vpc_endpoint_type" {
    description = "vpc endpoint type of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.vpc_endpoint_type 
}
output "dynamodb_vpc_id" {
    description = "vpc id of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.vpc_id 
}

output "dynamodb_cidr_blocks" {
    description = "cidr blocks of the dynamodb table name"
    value = aws_vpc_endpoint.dynamodb.cidr_blocks 
}