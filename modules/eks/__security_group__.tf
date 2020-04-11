
module "eks_master_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.cluster_name}-sg"
  vpc_id = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      description              = "Allow pods to communicate with the EKS cluster API."
      rule                     = "https-443-tcp"
      source_security_group_id = module.eks_worker_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = merge(local.tags, {
    Name = "${var.cluster_name}-sg"
  })
}

module "eks_worker_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${local.worker_name}-sg"
  vpc_id = var.vpc_id

  computed_ingress_with_self = [
    {
      description = "Allow pods to communicate with the cluster API Server"
      rule        = "all-all"
    }
  ]
  number_of_computed_ingress_with_self = 1

  computed_ingress_with_source_security_group_id = [
    {
      description              = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane."
      rule                     = "https-443-tcp"
      source_security_group_id = module.eks_master_sg.this_security_group_id
    },
    {
      description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
      protocol                 = "tcp"
      from_port                = 1025
      to_port                  = 65535
      source_security_group_id = module.eks_master_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  egress_with_cidr_blocks = [
    {
      rule = "all-all"
    }
  ]

  tags = merge(local.tags, {
    Name = "${local.worker_name}-sg"
  })
}

