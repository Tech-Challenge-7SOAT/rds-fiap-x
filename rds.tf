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
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.fiapx_rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
}

## Não deu certo, a esteira não consegue acessar o RDS para executar o script.

# resource "null_resource" "db_schema" {
#   depends_on = [aws_db_instance.postgres]

#   provisioner "local-exec" {
#     command = <<EOT
#       echo "Aguardando RDS ficar disponível..."
#       for i in {1..10}; do
#         pg_isready -h ${aws_db_instance.postgres.address} -U ${var.DB_USERNAME} && break
#         echo "Aguardando RDS... tentativa $i"
#         sleep 15
#       done
#       echo "Executando migração do banco de dados..."
#       PGPASSWORD=${var.DB_PASSWORD} psql -U ${var.DB_USERNAME} -d ${var.DB_NAME} -h ${aws_db_instance.postgres.address} -f ./db_schema.sql
#     EOT
#   }
# }