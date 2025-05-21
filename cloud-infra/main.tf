provider "aws" {
  region  = var.region
}

module "vpc" {
  source             = "./modules/vpc"
  cidr =  var.cidr
  subnets_list = var.subnets_list

}

module "compute" {
  source             = "./modules/compute"
  ami_id =  var.ami_id
  ec2_type = var.ec2_type
  public_subnet_id = module.vpc.subnet_ids["public_subnet1"] 
  public_subnet2_id = module.vpc.subnet_ids["public_subnet2"] 
  private_subnet_id = module.vpc.subnet_ids["private_subnet1"]
  ssh_SG_id = module.vpc.ssh_SG_id
  ssh_3000_SG_id = module.vpc.ssh_3000_SG_id
  lb_sg_id = module.vpc.lb_sg_id
  vpc_id = module.vpc.vpc_id

}



