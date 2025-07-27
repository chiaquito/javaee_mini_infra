terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Name    = "Main"
      Iac     = "true"
      Section = 1
      Dir ="public_service_wo_lb"
    }
  }
}

data "aws_s3_bucket" "tfstate" {
  bucket = "javaee-mini-infra"
}