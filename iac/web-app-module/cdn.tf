resource "aws_cloudfront_origin_access_control" "access_to_bucket" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_distribution" "website" {
  enabled = true
  #   aliases             = [var.domain_name] No tenemos certificado
  default_root_object = "index.html"
  origin {
    domain_name              = aws_s3_bucket.www.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.access_to_bucket.id

    origin_id       =  "S3-www.${var.domain_name}"
 
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       =  "S3-www.${var.domain_name}"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["AR"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
