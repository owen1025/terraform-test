
variable "eks_cluster_name" {
  type = string
}

variable "helm_tiller_sa_name" {
  type    = string
  default = "tiller"
}
