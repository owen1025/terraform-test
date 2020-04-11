#--------------------------------------------------------------
# terraform workspace info(remote)
#--------------------------------------------------------------
terraform {
  required_version = "~> 0.12.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "owen"
    workspaces {
      name = "terraform-test"
    }
  }
}

data "aws_availability_zones" "available" {}

locals {
  available_azs = data.aws_availability_zones.available.names

  tags = {
    environment = var.environment
    workspace   = "terraform-test"
    owner       = "jepil.choi"
  }
}
