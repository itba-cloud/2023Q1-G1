module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cloud-vpc-1"
  cidr = var.vpc_cidr_block

  azs             = var.availability_zones
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = []

  enable_nat_gateway = false
  enable_vpn_gateway = false

}