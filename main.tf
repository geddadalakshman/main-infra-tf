module "vpc" {
  source = "git::https://github.com/geddadalakshman/vpc-module.git"
  env = var.env
  tags = var.tags
  vpc_default_id = var.vpc_default_id
  vpc_default_route_table = var.vpc_default_route_table

  for_each = var.vpc
  vpc_cidr = each.value["vpc_cidr"]
  public_subnets = each.value["public_subnets"]
  private_subnets = each.value["private_subnets"]
}



#output "vpc" {
#  value = module.vpc
#}