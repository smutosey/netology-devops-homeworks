module "vpc_prod" {
  source  = "../../03-ter-04-advanced/src/vpc"
  name    = var.prod_env.vpc_name
  subnets = var.prod_env.subnets
}
