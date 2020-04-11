
variable "eks_cluster_name" {
  type = string
}

variable "eks_worker_iam_role_arn" {
  type = string
}

variable "helm_tiller_sa_name" {
  type    = string
  default = "tiller"
}

variable "jenkins_chart_version" {
  type    = string
  default = "1.9.12"
}
