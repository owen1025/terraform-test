#--------------------------------------------------------------
# Jenkins
#
# Variables
# - jenkins_chart_version{string} [default]
#--------------------------------------------------------------
# resource "helm_release" "jenkins" {
#   name      = "jenkins"
#   namespace = "kube-system"
#   chart     = "stable/jenkins"
#   version   = var.jenkins_chart_version
# }
