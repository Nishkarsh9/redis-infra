provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket  = "redis-infraa"
    key     = "redis-terraform/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
  public_route_table_id = module.vpc.public_route_table_id # Add this line
}

module "nat_gateway" {
  source             = "./modules/nat-gateway"
  public_subnet_id   = module.subnets.public_subnet_ids[0]
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.subnets.private_subnet_ids
}

module "bastion_host" {
  source           = "./modules/bastion-host"
  public_subnet_id = module.subnets.public_subnet_ids[0]
  bastion_sg_id    = module.vpc.bastion_sg_id
  key_name         = var.key_name
}

module "redis_servers" {
  source             = "./modules/redis-servers"
  private_subnet_ids = module.subnets.private_subnet_ids
  redis_sg_id        = module.vpc.redis_sg_id
  key_name           = var.key_name
}
