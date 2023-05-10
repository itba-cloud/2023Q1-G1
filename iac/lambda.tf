
# resource "aws_iam_role" "api_action_role" {
#   name = "web_api_lambda"

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

# resource "aws_iam_role_policy_attachment" "api_action_role_policy_attachment" {
#   policy_arn = aws_iam_policy.api_action_policy.arn
#   role       = aws_iam_role.api_action_role.name
# } -> Se comenta porque no tenemos permisos para attachear policies o crear roles

data "aws_iam_role" "lab_role" {
  name = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
} // Usamos un role ya existente dado que no podemos crear roles



resource "aws_iam_policy" "api_action_policy" {
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
        Resource = aws_dynamodb_table.inventory.arn
      }
    ]
  })
}


data "archive_file" "lambda" {
  for_each    = fileset("${path.module}/files", "*.js")
  type        = "zip"
  source_file = "files/${each.value}"
  output_path = "files/${split(".", each.value)[0]}.zip"
}


data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "api_action" {
  for_each      = fileset("${path.module}/files", "*.zip")
  function_name = split(".", each.value)[0]
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  filename      = "files/${each.value}"
  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole" // usamos LabRole porque no podemos crear roles o adjuntar policies

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.api_lambdas.id]
  }
}
resource "aws_security_group" "api_lambdas" {
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
