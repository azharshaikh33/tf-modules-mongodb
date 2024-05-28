# creating locals

locals {
  DOCDB_USER = jsondecode(aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USERNAME"]
  DOCDB_PASS = jsondecode(aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_PASSWORD"]
}