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

module "docdb" {
  source = "git::https://github.com/geddadalakshman/docdb-module.git"
  env = var.env
  tags = var.tags
  subnet_ids = local.db_subnet_ids

  for_each = var.docdb
  engine = each.value["engine"]
  engine_version = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot = each.value["skip_final_snapshot"]
  no_of_instances = each.value["no_of_instances"]
  instance_class = each.value["instance_class"]
}




#output "vpc" {
#  value = module.vpc
#}