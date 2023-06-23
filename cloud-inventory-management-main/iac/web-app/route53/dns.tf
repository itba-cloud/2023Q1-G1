resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.base_domain
  type    = "A"
  alias {
    name                   = var.cdn.domain_name
    zone_id                = var.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_zone" "this" {
  name = var.base_domain
}