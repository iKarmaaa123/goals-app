module "vpc" {
  source = "../modules/VPC"
  vpc_cidr_block = var.vpc_cidr_block
  cidr_block = var.cidr_block
  cidr_block2 = var.cidr_block2
  cidr_block3 = var.cidr_block3
  cidr_block4 = var.cidr_block4
  availability_zone = var.availability_zone
  availability_zone2 = var.availability_zone2
}

module "alb" {
  source = "../modules/ALB"
  vpc_id = module.vpc.vpc_id
  subnets = [module.vpc.public_subnet_id, module.vpc.public_subnet2_id]
  security_groups = [module.vpc.security_group_alb_id, module.vpc.security_group_ecs_id]
  domain_name = var.domain_name
  record_name = var.record_name
  record_type = var.record_type
  certificate_arn = module.acm.certificate_arn
}

module "route53" {
  source = "../modules/Route53"
  domain_name = var.domain_name
  record_name = var.record_name
  record_type = var.record_type
  records = [module.alb.alb_dns_name]
  alb_dns_name = module.alb.alb_dns_name
  zone_id = module.alb.alb_zone_id
}

module "acm" {
  source = "../modules/ACM"
  domain_name = var.domain_name
}


module "iam" {
  source = "../modules/IAM"
}

module "ecs" {
  source = "../modules/ECS"
  execution_role_arn = module.iam.task_execution_role_arn
  subnets = [module.vpc.private_subnet_id, module.vpc.private_subnet2_id]
  security_groups = [module.vpc.security_group_ecs_id, module.vpc.security_group_alb_id]
  target_group_arn = module.alb.target_group_arn
}

module "cloudwatch" {
  source = "../modules/CloudWatch"
}

#njbsgjksdkfskbd