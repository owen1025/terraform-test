#--------------------------------------------------------------
# Kubernetes config map - aws 
#--------------------------------------------------------------
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<CONFIGMAPAWSAUTH
- rolearn: ${var.eks_worker_iam_role_arn} 
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
CONFIGMAPAWSAUTH
  }
}
