#--------------------------------------------------------------
# Common variables
#--------------------------------------------------------------
variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "environment" {
  type = string
}

#--------------------------------------------------------------
# VPC variables
#--------------------------------------------------------------
variable "vpc_cidr_block_prefix" {
  type = string
}

#--------------------------------------------------------------
# EKS variables
#--------------------------------------------------------------
variable "cluster_name" {
  type = string
}

variable "worker_instance_type" {
  type    = string
  default = "t2.large"
}

variable "worker_desired_capacity" {
  type = number
}

variable "worker_min_size" {
  type = number
}

variable "worker_max_size" {
  type = number
}
