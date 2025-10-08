provider "aws" {
  
 profile = "prod"
}



module "vpc_creation" {
  source = "../../modules/vpc"
  cidr_block = var.cidr_block
  env = var.env
  public_subnet_cidr = var.public_subnet_cidr
  az=var.az
}

module "ec2-creation" {
source = "../../modules/ec2"
instance_type = var.instance_type
ami_id = var.ami_id
subnet_id = module.vpc_creation.public_subnet_id
env = var.env
}
