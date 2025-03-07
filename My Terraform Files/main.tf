module "alb" {
    source = "./modules/alb"
    security_group_id = module.network.LCT-SG-ID
    target_group_id = module.network.aws_lb_target_group-ID
}

module "ecs" {
    source = "./modules/ecs"
    security_group_id = module.network.LCT-SG-ID
    target_group_id = module.network.aws_lb_target_group-ID
}

module "network" {
    source = "./modules/network"
}