

resource "aws_cloudfront_distribution" "cf_dist" {
  enabled = true
  #   aliases             = [var.domain_name] No tenemos certificado
  default_root_object = "index.html"
  origin {
    domain_name              = aws_s3_bucket_website_configuration.www_bucket_configuration.website_endpoint
    origin_id       =  "S3-www.${var.domain_name}"
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       =  "S3-www.${var.domain_name}"
    viewer_protocol_policy = "allow-all" #"redirect-to-https" # other options - https only, http
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
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
