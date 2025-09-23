module "ec2_create_module" {
  source = "./child-module/ec2"
  ami_id = "ami-00ca32bbc84273381"
  az = "us-east-1a"
  instance_type = "t3.micro"
  subnet_id_for-ec2 = module.vpc-subnet_create_module.subnet-1a_id
 }

#ami = "ami-00ca32bbc84273381"


module "vpc-subnet_create_module" {
    source = "./child-module/vpc"
    vpc_cidr = "10.0.0.0/16"   

    az_for-subnet-1a = "us-east-1a"   #passing values for subnet-1a
    subnet_cidr-1a = "10.0.1.0/24"

    az_for-subnet-1b = "us-east-1b"      #passing values for subnet-1b
    subnet_cidr-1b = "10.0.2.0/24"

}

module "rds_create_module" {
  source = "./child-module/rds"
  db_name = "test_db"
  db_username = "admin"
  db_pass = "admin#123"
  db_subnetid_1a = module.vpc-subnet_create_module.subnet-1a_id   ###here we took these values from output.tf parameter of vpc_subnet_create.module
  db_subnetid_1b = module.vpc-subnet_create_module.subnet-1b_id   #####here we took these values from output.tf parameter vpc_subnet_create.module
}

##for examples

output "subnet-1a_id" {
  value = module.vpc-subnet_create_module.subnet-1a_id 
}

output "subnet-1b_id" {
  value = module.vpc-subnet_create_module.subnet-1b_id
}

############################################################################################################################

##output from ec2 module 

output "ec2_instance" {
    value = module.ec2_create_module.ec2_instance_id
}

output "ec2_instance_type" {
  value =module.ec2_create_module.ec2_instance_type
}

output "ec2_public-ip" {
  value = module.ec2_create_module.ec2_public-ip
}

output "ec2_private-ip" {
  value = module.ec2_create_module.ec2_private-ip
}

output "ec2_subnet_id" {
  value = module.ec2_create_module.ec2_subnet_id
}
####################################################################################################################################

##output from RDS module 

output "rds_db_name" {
  value = module.rds_create_module.rds_db_name
}

output "db_username" {
  value = module.rds_create_module.db_username
}

output "db_pass" {
value = module.rds_create_module.db_pass
sensitive = true
}

output "db_subnet_group_id" {
  value = module.rds_create_module.db_subnet_group_id 
}