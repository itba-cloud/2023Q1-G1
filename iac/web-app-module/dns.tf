# resource "aws_route53_zone" "primary" {
#   count = var.create_dns_zone ? 1 : 0
#   name  = var.domain_name
# }

# data "aws_route53_zone" "primary" {
#   count = var.create_dns_zone ? 0 : 1
#   name  = var.domain_name
# }

# locals {
#   dns_zone_id = var.create_dns_zone ? aws_route53_zone.primary[0].zone_id : data.aws_route53_zone.primary[0].zone_id
#   subdomain   = var.environment_name == "production" ? "" : "${var.environment_name}."
# }

# resource "aws_route53_record" "root" {
#   zone_id = local.dns_zone_id
#   name    = "${local.subdomain}${var.domain_name}"
#   type    = "A"


# }
