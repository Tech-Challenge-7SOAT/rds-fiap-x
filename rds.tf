resource "aws_db_instance" "postgres" {
  identifier              = "fiapx-db"
  allocated_storage       = 5
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "16.3"
  instance_class          = "db.t3.micro"
  db_name                 = var.DB_NAME
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  parameter_group_name    = "default.postgres16"
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.fiapx_rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
}

resource "null_resource" "db_schema" {
  depends_on = [aws_db_instance.postgres]

  provisioner "local-exec" {
    command = "export PGPASSWORD=${var.DB_PASSWORD}; sleep 60; psql -U ${var.DB_USERNAME} -d ${var.DB_NAME} -h ${aws_db_instance.postgres.address} -f ./db_schema.sql"
  }
}