resource "aws_elasticache_cluster" "elasticacher" {
  cluster_id        = "${var.env}-elasticache"
  engine            = var.engine
  engine_version    = var.engine_version
  node_type         = var.node_type
  num_cache_nodes   = var.num_cache_nodes
  port              = 6379
  subnet_group_name = aws_docdb_subnet_group.subgrpr

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

