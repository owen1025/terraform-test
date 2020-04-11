
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.environment}-eks-vpc"
  cidr = "${var.vpc_cidr_block_prefix}.0.0/16"

  azs = local.available_azs

  public_subnets = [
    for az in local.available_azs :
    cidrsubnet("${var.vpc_cidr_block_prefix}.0.0/16", 4, index(local.available_azs, az) + 8)
  ]
  private_subnets = [
    for az in local.available_azs :
    cidrsubnet("${var.vpc_cidr_block_prefix}.0.0/16", 4, index(local.available_azs, az))
  ]
  database_subnets = [
    for az in local.available_azs :
    cidrsubnet("${var.vpc_cidr_block_prefix}.0.0/16", 8, index(local.available_azs, az) + 224)
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_route_table = true

  public_subnet_tags = merge(local.tags, {
    "kubernetes.io/role/elb" = 1
  })

  private_subnet_tags = merge(local.tags, {
    "kubernetes.io/role/internal-elb" = 1
  })

  tags = merge(local.tags, {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}
