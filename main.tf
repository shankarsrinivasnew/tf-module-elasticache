resource "aws_elasticache_cluster" "elasticacher" {
  cluster_id        = "${var.env}-elasticache"
  engine            = var.engine
  engine_version    = var.engine_version
  node_type         = var.node_type
  num_cache_nodes   = var.num_cache_nodes
  port              = 6379
  subnet_group_name = aws_elasticache_subnet_group.subgrpr.name

  tags = merge(
    var.tags,
    { Name = "${var.env}-subnet-group" }
  )
}

resource "aws_elasticache_subnet_group" "subgrpr" {
  name       = "${var.env}-elasticache-subnetgroup"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    { Name = "${var.env}-subnet-group" }
  )
}

/* resource "aws_ssm_parameter" "redis_endpoint" {
  name  = "${var.env}.redis_endpoint"
  type  = "String"
  value = aws_elasticache_cluster.elasticacher.id
} */

output "myelasticcacheout" {
  value = aws_elasticache_cluster.elasticacher
  
}


