
locals {
  worker_name     = "${var.environment}-eks-worker"
  worker_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA

  tags = merge(var.tags, {
    TerraformModuleName = "modules/eks"
  })
}
