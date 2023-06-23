module "dynamodb_table" {
  source = "./web-app/database"

  db_name = "Inventory"
  db_pass = "admin"
  db_user = "admin"
}

module "vpc" {
  source             = "./web-app/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  availability_zones = ["us-east-1a"]
}

module "route53" {
  source      = "./web-app/route53"
  base_domain = "cloudinventorymanagement.com"
  cdn         = module.cdn.cloudfront_distribution
}

module "web_site" {
  source                  = "./web-app/static_site"
  nextjs_export_directory = var.nextjs_export_directory
}

module "lambda" {
  source                            = "./web-app/lambda"
  vpc_id                            = module.vpc.vpc_id
  dynamodb_vpc_endpoint_cidr_blocks = module.vpc-endpoint.dynamodb_cidr_blocks
  dynamodb_arn                      = module.dynamodb_table.dynamodb_arn
  vpc_private_subnets               = module.vpc.vpc_private_subnets
}

module "cdn" {
  source                  = "./web-app/cdn"
  static_site             = module.web_site.domain_name
  web_origin_id           = local.static_origin_id
  logs_bucket_domain_name = module.web_site.logs_bucket_domain_name
}

module "vpc-endpoint" {
  source                      = "./web-app/vpc-endpoint"
  vpc_id                      = module.vpc.vpc_id
  vpc_private_route_table_ids = module.vpc.vpc_private_route_table_ids

}