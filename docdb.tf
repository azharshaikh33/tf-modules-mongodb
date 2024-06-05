# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier = "roboshop-${var.ENV}-docdb"
# }

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  # engine_version          = "4.0.0"
  master_username         = local.DOCDB_USER
  master_password         = local.DOCDB_PASS
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name

}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "roboshop-${var.ENV}-docdb"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.DOCDB_INSTANCE_COUNT
  identifier         = "roboshop-${var.ENV}-docdb-instance"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.DOCDB_INSTANCE_CLASS
}