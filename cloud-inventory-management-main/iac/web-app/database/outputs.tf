output "dynamodb_arn" {
    description = "arn of the dynamodb table name"
    value = aws_dynamodb_table.inventory.arn
}