# Create a security group
resource "aws_security_group" "allow_mongodb" {
  name        = "roboshop-${var.ENV}-mongodb-sg"
  description = "Allow MOngodb internal inbound traffic"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  # Inbound rules
  ingress {
    description = "Allow Docdb from local network"
    from_port   = var.DOCDB_PORT
    to_port     = var.DOCDB_PORT
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  #   ingress {
  #   description = "Allow Docdb from local network"
  #   from_port   = var.DOCDB_PORT
  #   to_port     = var.DOCDB_PORT
  #   protocol    = "tcp"
  #   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  # }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mongodb-sg"
  }
}