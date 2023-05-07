
resource "aws_iam_role" "example_lambda_role" {
  name = "example-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_policy" "example_lambda_policy" {
  name        = "example-lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
        ]
        Effect = "Allow"
        Resource = "arn:aws:dynamodb:<region>:<account_id>:table/example-table"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example_lambda_role_policy_attachment" {
  policy_arn = aws_iam_policy.example_lambda_policy.arn
  role       = aws_iam_role.example_lambda_role.name
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "example-lambda"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  filename      = "index.js.zip"
  role          = aws_iam_role.example_lambda_role.arn

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}
resource "aws_security_group" "lambda_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.default_vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.default_vpc_cidr_block]
  }


  tags = {
    Name = "dynamo_vpc_sg"
  }
}
