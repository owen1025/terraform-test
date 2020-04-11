
module "kubernetes" {
  source = "../../modules/kubernetes"

  eks_cluster_name = var.cluster_name
}
