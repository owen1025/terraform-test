#--------------------------------------------------------------
# helm-tiller service account
# 
# - Role binding: cluster-admin
#--------------------------------------------------------------
resource "kubernetes_service_account" "helm-tiller" {
  metadata {
    name      = var.helm_tiller_sa_name
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "helm-tiller" {
  metadata {
    name = var.helm_tiller_sa_name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.helm-tiller.metadata[0].name
    namespace = "kube-system"
  }
}

