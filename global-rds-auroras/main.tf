provider "aws" {
  region = "eu-west-2"
}

resource "aws_rds_cluster" "primary_cluster" {
  cluster_identifier      = "primary-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"
  database_name           = "mydb"
  master_username         = "dbadmin"
  master_password         = "password"
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "primary_instance" {
  identifier         = "primary-instance"
  cluster_identifier = aws_rds_cluster.primary_cluster.id
  instance_class     = "db.r4.large"
  engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.07.1"
}

provider "aws" {
  alias  = "secondary"
  region = "ap-southeast-2"
}

resource "aws_rds_global_cluster" "global" {
  provider                  = aws.secondary
  global_cluster_identifier = "global-cluster"
  source_db_cluster_identifier = aws_rds_cluster.primary_cluster.arn  
  force_destroy                 = false
}

resource "aws_rds_cluster" "secondary_cluster" {
  provider                  = aws.secondary
  cluster_identifier        = "secondary-cluster"
  global_cluster_identifier = aws_rds_global_cluster.global.id
  engine                    = "aurora-mysql"
  engine_version            = "5.7.mysql_aurora.2.07.1"
  skip_final_snapshot       = true
  depends_on                = [aws_rds_cluster_instance.primary_instance]
}

resource "aws_rds_cluster_instance" "secondary_instance" {
  provider            = aws.secondary
  identifier          = "secondary-instance"
  cluster_identifier  = aws_rds_cluster.secondary_cluster.id
  instance_class      = "db.r4.large"
  engine              = "aurora-mysql"
  engine_version      = "5.7.mysql_aurora.2.07.1"
}
