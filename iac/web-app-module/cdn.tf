#creating OAI :
# resource "aws_cloudfront_origin_access_identity" "oai" {
#   comment = "OAI for ${var.domain_name}"
# }

# cloudfront terraform - creating AWS Cloudfront distribution :
# resource "aws_cloudfront_distribution" "cf_dist" {
#   enabled             = true
#   aliases             = [var.domain_name]
#   default_root_object = "website/index.html"
#   origin {
#     domain_name = aws_s3_bucket.www_bucket.bucket_regional_domain_name
#     origin_id   = aws_s3_bucket.www_bucket.id
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
#     }
#   }
#   default_cache_behavior {
#     allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#     cached_methods         = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id       = aws_s3_bucket.www_bucket.id
#     viewer_protocol_policy = "allow-all" #"redirect-to-https" # other options - https only, http
#     forwarded_values {
#       headers      = []
#       query_string = true
#       cookies {
#         forward = "all"
#       }
#     }
#   }
#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["AR"]
#     }
#   }

#   viewer_certificate {
#     acm_certificate_arn      = aws_acm_certificate.cert.arn
#     ssl_support_method       = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2018"
#   }
# }

# data "aws_iam_policy_document" "bucket_policy_document" {
#   statement {
#     actions = ["s3:GetObject"]
#     resources = [
#       aws_s3_bucket.www_bucket.arn,
#       "${aws_s3_bucket.www_bucket.arn}/*"
#     ]
#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
#     }
#   }
# }