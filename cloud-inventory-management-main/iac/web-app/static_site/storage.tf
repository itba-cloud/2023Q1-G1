resource "aws_s3_bucket" "www" {
  bucket        = "www.${var.domain_name}"
  force_destroy = true
}
resource "aws_s3_bucket" "root" {
  bucket        = var.domain_name
  force_destroy = true
}
resource "aws_s3_bucket" "logs" {
  bucket        = "logs.${var.domain_name}"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# # resource "aws_s3_bucket_policy" "logs" {
#   bucket   = aws_s3_bucket.logs.id

#      policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "AllowCloudFrontToPutLogs",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "cloudfront.amazonaws.com"
#       },
#       "Action": "s3:PutObject",
#       "Resource": "arn:aws:s3:::logs.${var.domain_name}/*",
#       "Condition": {
#         "StringEquals": {
#           "aws:SourceArn": [
#             "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.website["root"].id}",
#             "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.website["www"].id}"
#           ]
#         }
#       }
#     }
#   ]
# }
# POLICY
# }

resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  bucket     = aws_s3_bucket.logs.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.logs]
}


resource "aws_s3_bucket_cors_configuration" "website" {
  bucket = aws_s3_bucket.root.id
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*", "https://www.${var.domain_name}"] // En realidad, seria solo nuestro domain_name
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_website_configuration" "root" {
  bucket = aws_s3_bucket.www.id
  redirect_all_requests_to {
    host_name = "https://www.${var.domain_name}"
  }
}
resource "aws_s3_bucket_website_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = var.nextjs_export_directory
}

resource "aws_s3_object" "website_files" {
  for_each     = module.template_files.files
  bucket       = aws_s3_bucket.www.id
  key          = each.key
  content_type = each.value.content_type
  source       = each.value.source_path
  content      = each.value.content
  etag         = each.value.digests.md5
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.logs.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "logs/"
}
