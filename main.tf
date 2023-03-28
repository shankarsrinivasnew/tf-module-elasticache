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

resource "aws_ssm_parameter" "redis_endpoint" {
  name  = "${var.env}.elasticache_endpoint"
  type  = "String"
  value = aws_elasticache_cluster.elasticacher.cache_nodes[0].address
}


/* output "myelasticacheout" {
  value = aws_elasticache_cluster.elasticacher
  
} */

resource "aws_security_group" "sgr" {
  name        = "elasricache-${var.env}-sg"
  description = "elasricache-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "elasricache port"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = var.allow_db_to_subnets
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
      var.tags,
      { Name = "elasricache-${var.env}" }
    )
}