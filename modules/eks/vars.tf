
variable "environment" {
  type = string
}

variable "tags" {
  type = map
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.14"
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list
}

variable "instance_type" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "worker_min_size" {
  type = number
}

variable "worker_max_size" {
  type = number
}

variable "worker_ami_name_filter" {
  type    = list(string)
  default = ["amazon-eks-node-1.14-v*"]
}

variable "worker_ami_owners" {
  type    = list(string)
  default = ["602401143452"]
}
