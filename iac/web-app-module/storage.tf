# TODO: https://www.alexhyett.com/terraform-s3-static-website-hosting/



# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket        = "www.${var.domain_name}"
  force_destroy = true
}
resource "aws_s3_bucket" "root_bucket" {
  bucket        = var.domain_name
  force_destroy = true
}
locals {
  bucket_ids = {
    www_bucket = aws_s3_bucket.www_bucket.id
    root_bucket = aws_s3_bucket.root_bucket.id
  }
}
resource "aws_s3_bucket_ownership_controls" "www_bucket" {
  for_each = local.bucket_ids
  bucket = each.value
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "www_bucket" {
  for_each = local.bucket_ids
  bucket = each.value

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "www_bucket" {
  for_each = local.bucket_ids
  bucket   = each.value

  policy        = templatefile("${path.module}/s3-policy.json", { bucket = "${each.key == "www_bucket" ? "www." : ""}${var.domain_name}" })

}
resource "aws_s3_bucket_acl" "www_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.www_bucket, aws_s3_bucket_public_access_block.www_bucket]
  for_each = local.bucket_ids
  bucket   = each.value
  acl      = "public-read"


}

resource "aws_s3_bucket_cors_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*","https://www.${var.domain_name}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "www_bucket_configuration" {
  bucket = aws_s3_bucket.www_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}



resource "aws_s3_bucket_website_configuration" "root_bucket_configuration" {
  bucket = aws_s3_bucket.root_bucket.id
  redirect_all_requests_to {
    host_name = "https://www.${var.domain_name}"
  }
}
module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${var.nextjs_export_directory}"

}

resource "aws_s3_object" "website_files" {
  for_each = module.template_files.files
  bucket   = aws_s3_bucket.www_bucket.id
  key      = each.key
  content_type = each.value.content_type
  source   = each.value.source_path
  content = each.value.content
  etag     = each.value.digests.md5
}
