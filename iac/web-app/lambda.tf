
# resource "aws_iam_role" "example_lambda_role" {
#   name = "example-lambda-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })

# }

data "aws_iam_role" "lab_role" {
  name = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
}
resource "aws_iam_policy" "example_lambda_policy" {
  name = "example-lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.inventory_table.arn
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "example_lambda_role_policy_attachment" {
#   policy_arn = aws_iam_policy.example_lambda_policy.arn
#   role       = aws_iam_role.example_lambda_role.name
# }

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.js"
  output_path = "index.zip"
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "example-lambda"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  filename      = "index.zip"
  role          = "arn:aws:iam::739329471372:role/LabRole" // este por ahora cada uno tiene que ir cambiandolo
  // "arn:aws:iam::739329471372:role/LabRole"

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}
resource "aws_security_group" "lambda_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = aws_vpc_endpoint.default.cidr_blocks
  }


  tags = {
    Name = "dynamo_vpc_sg"
  }
}
