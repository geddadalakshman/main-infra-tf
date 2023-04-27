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

#module "docdb" {
#  source = "git::https://github.com/geddadalakshman/docdb-module.git"
#  env = var.env
#  tags = var.tags
#  subnet_ids = local.db_subnet_ids
#
#  for_each = var.docdb
#  engine = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  backup_retention_period = each.value["backup_retention_period"]
#  preferred_backup_window = each.value["preferred_backup_window"]
#  skip_final_snapshot = each.value["skip_final_snapshot"]
#  no_of_instances = each.value["no_of_instances"]
#  instance_class = each.value["instance_class"]
#}
#
#module "rds" {
#  source = "git::https://github.com/geddadalakshman/rds-module.git"
#  env = var.env
#  tags = var.tags
#  subnet_ids = local.db_subnet_ids
#
#  for_each = var.rds
#  engine = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  backup_retention_period = each.value["backup_retention_period"]
#  preferred_backup_window = each.value["preferred_backup_window"]
#  skip_final_snapshot = each.value["skip_final_snapshot"]
#  no_of_instances = each.value["no_of_instances"]
#  instance_class = each.value["instance_class"]
#}
#
#
#module "elasticache" {
#  source = "git::https://github.com/geddadalakshman/redis-module.git"
#  env = var.env
#  tags = var.tags
#  subnet_ids = local.db_subnet_ids
#
#  for_each = var.elasticache
#  engine = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  num_cache_nodes = each.value["num_cache_nodes"]
#  node_type = each.value["node_type"]
#}
#
#module "rabbitmq" {
#  source = "git::https://github.com/geddadalakshman/rabbitmq-module.git"
#  env = var.env
#  tags = var.tags
#  subnet_ids = local.db_subnet_ids
#
#  for_each = var.rabbitmq
#  instance_type = each.value["instance_type"]
#}

module "alb" {
  source = "git::https://github.com/geddadalakshman/alb-module.git"
  env = var.env
  tags = var.tags

  for_each = var.alb
  name = each.value["name"]
  internal = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null )
}

module "apps" {
  source = "git::https://github.com/geddadalakshman/apps-module.git"
  env = var.env
  tags = var.tags
  bastion_cidr = var.bastion_cidr

  vpc_id = module.vpc[main].vpc_id

  for_each = var.apps
  component = each.value["component"]
  instance_type = each.value["instance_type"]
  desired_capacity = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size = each.value["min_size"]
  subnets = lookup(local.subnet_ids, each.value["subnet_name"], null )
}


#output "alb" {
#  value = module.vpc
#}


