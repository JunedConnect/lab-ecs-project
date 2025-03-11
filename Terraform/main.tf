module "alb" {
    source = "./modules/alb"
    security_group_id = module.network.LCT-SG-ID
    target_group_id = module.network.aws_lb_target_group-ID
    certificate_arn = module.route53.certificate_arn
    subnets = module.network.subnet_ids
}

module "ecs" {
    source = "./modules/ecs"
    security_group_id = module.network.LCT-SG-ID
    target_group_id = module.network.aws_lb_target_group-ID
    subnets = module.network.subnet_ids
}

module "network" {
    source = "./modules/network"
    vpc_id = module.network.vpc_id
}

module "route53" {
    source = "./modules/route53"
    alb_dns_name = module.alb.LCT-ALB-DNS
    alb_zone_id = module.alb.LCT-ALB-ZONE-ID
}