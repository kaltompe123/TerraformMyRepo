module "VPCandBastion_creation_module" {
  source      = "../modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  pubsub1cidr = "10.0.0.0/24"
  pubsub2cidr = "10.0.1.0/24"
  pvt3subcidr = "10.0.2.0/24"
  pvt4subcidr = "10.0.3.0/24"
  pvt5subcidr = "10.0.4.0/24"
  pvt6subcidr = "10.0.5.0/24"
  pvt7subcidr = "10.0.6.0/24"
  pvt8subcidr = "10.0.7.0/24"

}

module "TGandLB_create_module" {
  source             = "../modules/TG and LB"
  load_balancer_type = "application"
  vpc_id             = module.VPCandBastion_creation_module.vpc_id
  vpcname            = module.VPCandBastion_creation_module.vpc_name
  alb_backend_sg_id = module.SG_create.alb-backend-sg
  alb_frontend_sg-id = module.SG_create.alb-frontend-sg
  subpub1_id = module.VPCandBastion_creation_module.pub1-subid
  subpub2_id = module.VPCandBastion_creation_module.pub2-subid
}

module "SG_create" {

  source                 = "../modules/SG"
  bastion_host-sg-tag    = "bastion-host-server-sg"
  backend-server-sg-tag  = "backend-server-sg"
  frontend-server-sg-tag = "frontend-server-sg"
  alb-frontend-sg-tag    = "alb-frontend-sg"
  alb-backend-sg-tag     = "alb-backend-sg"
  book-rds-sg-tag        = "book-rds-sg"
  vpc_id                 = module.VPCandBastion_creation_module.vpc_id
  vpcname                = module.VPCandBastion_creation_module.vpc_name

}

module "rds_create" {
  source        = "../modules/rds"
  rds-username  = "admin"
  rds-password  = "root1234"
  prvt7-subid   = module.VPCandBastion_creation_module.prvt7-subid
  prvt8-subid   = module.VPCandBastion_creation_module.prvt8-subid
  book-rds-sgid = module.SG_create.book-rds-sgid
}

module "launch_temp_create_module" {
  source        = "../modules/launch_template"
  frontend-ami  = "frontend-ami"
  backend-ami   = "backend-ami"
  keyname       = "16thnovprojkey"
  frontendsg_id = module.SG_create.frontendsg_id
  backendsg_id  = module.SG_create.backendsg_id
}

module "autoscaling_create_module" {
  source           = "../modules/autoscaling"
  frontend-asg-tag = "frontend-asg"
  backend-asg-tag  = "backend-asg"
  prvt3_subid      =  module.VPCandBastion_creation_module.prvt3_subid
  prvt4_subid      = module.VPCandBastion_creation_module.prvt4_subid
  prvt5_subid      = module.VPCandBastion_creation_module.prvt5-subid
  prvt6_subid      = module.VPCandBastion_creation_module.prvt6-subid
  aws_launch_template_backend_id = module.launch_temp_create_module.aws_launch_template_backend_id
  aws_launch_template_backend_latest_version = module.launch_temp_create_module.aws_launch_template_backend_latest_version
  aws_launch_template_frontend_id = module.launch_temp_create_module.aws_launch_template_frontend_id
  aws_launch_template_frontend_latest_version = module.launch_temp_create_module.aws_launch_template_frontend_latest_version
  aws_lb_target_group_back_end_arn = module.TGandLB_create_module.aws_lb_target_group_back_end_arn
  aws_lb_target_group_front_end_arn = module.TGandLB_create_module.aws_lb_target_group_front_end_arn
  }



module "bastion_host_create" {
  source = "../modules/bastionhost"
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  bastion_hostsg_id = module.SG_create.bastion_hostsg_id
  pub1-subid = module.VPCandBastion_creation_module.pub1-subid
  key_name = "16thnovprojkey"
}