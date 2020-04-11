#--------------------------------------------------------------
# Provider(aws) info
#
# - default: ap-northeast-2(seoul)
#--------------------------------------------------------------
provider "aws" {
  version = "~> 2.0"
  region  = var.region
}
