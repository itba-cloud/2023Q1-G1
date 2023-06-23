resource "aws_cloudfront_origin_access_control" "access_to_bucket" {
  name                              = "S3 Access Control"
  description                       = "WWW bucket OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Access to S3 bucket"
}

resource "aws_cloudfront_distribution" "this" {
  enabled  = true
  retain_on_delete    = true # Esto va a hacer que se deshabilite cuando haces terraform destroy
  default_root_object =  "index.html"
    
  logging_config {
    bucket         = var.logs_bucket_domain_name
    include_cookies = false
    prefix         = "logs/"
  }
  # Como comentamos antes. El index.html está en el bucket root. El www está vacío o debería estarlo y deberían redirigirse los requests al root.

  origin {
    domain_name = var.static_site
    origin_id   = var.web_origin_id
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.web_origin_id

    viewer_protocol_policy = "https-only"

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
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true // Utilizamos el certificado de cloudfront a pesar de que lo ideal seria generar o importar un certificado con ACM y habilitar un alias hacia nuestro dominio
  }
}
