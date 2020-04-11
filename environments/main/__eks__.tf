
module "eks" {
  source = "../../modules/eks"

  environment = var.environment
  tags        = local.tags

  cluster_name = var.cluster_name

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  instance_type    = var.worker_instance_type
  desired_capacity = var.worker_desired_capacity
  worker_min_size  = var.worker_min_size
  worker_max_size  = var.worker_max_size
}
