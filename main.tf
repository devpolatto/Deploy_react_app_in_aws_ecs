terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }


  backend "s3" {
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region  = local.region
  profile = local.profile
}

data "aws_ecr_repository" "ecr-repository" {
  name = "react-app"
}

data "aws_network_interfaces" "interfaces" {
  tags = {
    ALIAS_PROJECT = "Depoy React App in AWS ECS"
  }
}