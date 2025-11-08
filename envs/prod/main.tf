terraform {
  required_providers {
    random = { source = "hashicorp/random" }
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  name     = "demo-prod"
  cidr     = "10.0.0.0/16"
  az_count = 2
}

module "eks" {
  source     = "../../modules/eks"
  name       = "demo-prod"
  subnet_ids = module.vpc.public_subnets
}

module "rds" {
  source     = "../../modules/rds"
  name       = "demo-prod"
  subnet_ids = module.vpc.public_subnets
  username   = "appuser"
  password   = "ChangeMe"
}

module "assets" {
  source = "../../modules/s3"
  name   = "demo-prod"
}

output "summary" {
  value = {
    vpc_id = module.vpc.vpc_id,
    eks    = module.eks.cluster_name,
    rds    = module.rds.rds_endpoint,
    bucket = module.assets.bucket
  }
}
