
resource "aws_vpc_endpoint" "dynamodb" {

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.vpc_private_route_table_ids
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
        ]
        Resource = "*"
      }
    ]
  })

}

resource "aws_vpc_endpoint_route_table_association" "private-dynamodb" {
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
  route_table_id  = var.vpc_private_route_table_ids[0]
}
