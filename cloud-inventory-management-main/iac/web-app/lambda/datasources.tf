data "archive_file" "lambda" {
  for_each    = fileset("${path.module}/files", "*.js")
  type        = "zip"
  source_file = "files/${each.value}"
  output_path = "files/${split(".", each.value)[0]}.zip"
}

data "aws_caller_identity" "current" {}