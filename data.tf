data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "azhar-roboshop-project-tfstate"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"

    }
}

data "aws_secretsmanager_secret" "secrets" {
  name = "roboshop1/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id     = "arn:aws:secretsmanager:us-east-1:992382483280:secret:roboshop1/secrets-CZGt0N"
}