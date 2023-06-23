#STATIC_SITE
locals {
  bucket_ids = {
    www  = aws_s3_bucket.www.id
    root = aws_s3_bucket.root.id
  }

  log_bucket_id = {
    log = aws_s3_bucket.logs.id
  }

}